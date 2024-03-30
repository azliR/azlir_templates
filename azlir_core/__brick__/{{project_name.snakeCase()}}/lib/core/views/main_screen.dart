import 'dart:async';

import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name}}/app/constants/constant.dart';
import 'package:{{project_name}}/app/routes/app_router.gr.dart';
import 'package:material_symbols_icons/symbols.dart';

enum NavigationTab { home, settings }

enum NavigationType { bottom, rail, drawer }

class AdaptiveScaffoldDestination {
  const AdaptiveScaffoldDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
  final String label;
  final Icon icon;
  final Icon selectedIcon;
}

@RoutePage()
class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({
    this.initialNavigation = NavigationTab.home,
    super.key,
  });

  final NavigationTab initialNavigation;

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final _tabsRouterCompleter = Completer<TabsRouter>();

  var _currentPage = 0;

  List<PageRouteInfo<dynamic>> get _routes =>
      NavigationTab.values.map((section) {
        return switch (section) {
          NavigationTab.home => const CounterRoute(),
          NavigationTab.settings => const SettingsRoute(),
        } as PageRouteInfo<dynamic>;
      }).toList();

  List<AdaptiveScaffoldDestination> get _destinations {
    return NavigationTab.values.map((section) {
      switch (section) {
        case NavigationTab.home:
          return const AdaptiveScaffoldDestination(
            icon: Icon(Symbols.home_rounded),
            selectedIcon: Icon(Symbols.home_rounded, fill: 1),
            label: 'Home',
          );
        case NavigationTab.settings:
          return const AdaptiveScaffoldDestination(
            icon: Icon(Symbols.settings_rounded),
            selectedIcon: Icon(Symbols.settings_rounded, fill: 1),
            label: 'Settings',
          );
      }
    }).toList();
  }

  void _onNavigationChanged(TabsRouter tabsRouter, int index) {
    if (index != tabsRouter.activeIndex) {
      tabsRouter.setActiveIndex(index);
    } else {
      tabsRouter.stackRouterOfIndex(index)?.popUntilRoot();
    }
  }

  @override
  void initState() {
    _currentPage = widget.initialNavigation.index;

    _tabsRouterCompleter.future.then((tabsController) {
      tabsController
        ..setActiveIndex(widget.initialNavigation.index)
        ..addListener(() {
          if (!context.mounted) return;
          setState(() {
            _currentPage = tabsController.activeIndex;
          });
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final size = MediaQuery.sizeOf(context);
    final orientation = MediaQuery.orientationOf(context);
    final padding = MediaQuery.paddingOf(context);

    final NavigationType navigationType;
    if (size.width < 600) {
      if (orientation == Orientation.portrait) {
        navigationType = NavigationType.bottom;
      } else {
        navigationType = NavigationType.rail;
      }
    } else if (size.width < 1280) {
      navigationType = NavigationType.rail;
    } else {
      navigationType = NavigationType.drawer;
    }
    final navigationTab = NavigationTab.values[_currentPage];

    return AutoTabsRouter(
      curve: Curves.easeInOut,
      routes: _routes,
      transitionBuilder: (context, child, animation) => FadeThroughTransition(
        animation: animation,
        secondaryAnimation: ReverseAnimation(animation),
        fillColor: theme.colorScheme.background,
        child: child,
      ),
      builder: (context, child) {
        final tabsRouter = context.tabsRouter;
        if (!_tabsRouterCompleter.isCompleted) {
          _tabsRouterCompleter.complete(tabsRouter);
        }
        _currentPage = tabsRouter.activeIndex;

        return Scaffold(
          backgroundColor: ElevationOverlay.applySurfaceTint(
            theme.colorScheme.surface,
            theme.colorScheme.surfaceTint,
            2,
          ),
          bottomNavigationBar: navigationType == NavigationType.bottom
              ? NavigationBar(
                  selectedIndex: tabsRouter.activeIndex,
                  onDestinationSelected: (index) =>
                      _onNavigationChanged(tabsRouter, index),
                  destinations: _destinations
                      .map(
                        (destination) => NavigationDestination(
                          label: destination.label,
                          icon: destination.icon,
                          selectedIcon: destination.selectedIcon,
                        ),
                      )
                      .toList(),
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButton: () {
            if (navigationType != NavigationType.bottom) return null;

            return _buildLargeFAB(navigationTab);
          }(),
          body: Row(
            children: [
              if (navigationType == NavigationType.drawer)
                NavigationDrawer(
                  selectedIndex: tabsRouter.activeIndex,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  onDestinationSelected: (index) =>
                      _onNavigationChanged(tabsRouter, index),
                  children: [
                    SizedBox(height: padding.top + 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        Constant.appName,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: _buildExtendedFAB(navigationTab),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ..._destinations.map(
                      (destination) => NavigationDrawerDestination(
                        icon: destination.icon,
                        selectedIcon: destination.selectedIcon,
                        label: Text(destination.label),
                      ),
                    ),
                  ],
                )
              else if (navigationType == NavigationType.rail)
                NavigationRail(
                  selectedIndex: _currentPage,
                  backgroundColor: Colors.transparent,
                  leading: _buildFAB(navigationTab),
                  labelType: NavigationRailLabelType.all,
                  groupAlignment: -0.2,
                  onDestinationSelected: (index) =>
                      _onNavigationChanged(tabsRouter, index),
                  destinations: _destinations
                      .map(
                        (destination) => NavigationRailDestination(
                          label: Text(destination.label),
                          icon: destination.icon,
                          selectedIcon: destination.selectedIcon,
                        ),
                      )
                      .toList(),
                ),
              Expanded(
                child: Padding(
                  padding: navigationType != NavigationType.bottom
                      ? const EdgeInsets.all(16)
                      : EdgeInsets.zero,
                  child: ClipRRect(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: navigationType != NavigationType.bottom
                        ? const BorderRadius.all(Radius.circular(24))
                        : BorderRadius.zero,
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLargeFAB(NavigationTab navigationTab) {
    return switch (navigationTab) {
      NavigationTab.home => FloatingActionButton.large(
          key: const ValueKey('add_home'),
          tooltip: 'Add',
          elevation: 0,
          onPressed: () {},
          child: const Icon(Symbols.add_rounded),
        ),
      NavigationTab.settings => FloatingActionButton.large(
          key: const ValueKey('add_settings'),
          tooltip: 'Add',
          elevation: 0,
          onPressed: () {},
          child: const Icon(Symbols.add_rounded),
        ),
    };
  }

  Widget _buildFAB(NavigationTab navigationTab) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      duration: const Duration(milliseconds: 250),
      child: switch (navigationTab) {
        NavigationTab.home => FloatingActionButton(
            key: const ValueKey('add_home'),
            tooltip: 'Add',
            elevation: 0,
            onPressed: () {},
            child: const Icon(Symbols.add_rounded),
          ),
        NavigationTab.settings => FloatingActionButton(
            key: const ValueKey('add_settings'),
            tooltip: 'Add',
            elevation: 0,
            onPressed: () {},
            child: const Icon(Symbols.add_rounded),
          ),
      },
    );
  }

  Widget _buildExtendedFAB(NavigationTab navigationTab) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      duration: const Duration(milliseconds: 250),
      child: switch (navigationTab) {
        NavigationTab.home => FloatingActionButton.extended(
            key: const ValueKey('add_home'),
            tooltip: 'Add',
            elevation: 0,
            onPressed: () {},
            icon: const Icon(Symbols.add_rounded),
            label: const Text('Add'),
          ),
        NavigationTab.settings => FloatingActionButton.extended(
            key: const ValueKey('add_settings'),
            tooltip: 'Add',
            elevation: 0,
            onPressed: () {},
            icon: const Icon(Symbols.add_rounded),
            label: const Text('Add'),
          ),
      },
    );
  }
}
