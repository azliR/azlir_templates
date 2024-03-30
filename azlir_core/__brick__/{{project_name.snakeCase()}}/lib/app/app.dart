import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name}}/app/helpers/injection.dart';
import 'package:{{project_name}}/app/l10n/l10n.dart';
import 'package:{{project_name}}/app/observers/app_auto_route_observer.dart';
import 'package:{{project_name}}/app/routes/app_router.dart';
import 'package:{{project_name}}/app/themes/app_theme.dart';
import 'package:{{project_name}}/features/settings/providers/settings/settings_provider.dart';
import 'package:loader_overlay/loader_overlay.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  final _appRouter = getIt<AppRouter>();

  @override
  void didChangeDependencies() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Theme.of(context).brightness,
        statusBarBrightness: Theme.of(context).brightness,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    final currentBrightness = Theme.of(context).brightness;

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        final lightColorScheme =
            lightDynamic ?? ColorScheme.fromSeed(seedColor: Colors.blue);
        final darkColorScheme = darkDynamic ??
            ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            );

        return GlobalLoaderOverlay(
          useDefaultLoading: false,
          useBackButtonInterceptor: true,
          duration: const Duration(milliseconds: 250),
          reverseDuration: const Duration(milliseconds: 250),
          overlayColor: switch (currentBrightness) {
            Brightness.dark => darkColorScheme.surface.withOpacity(0.5),
            Brightness.light => lightColorScheme.surface.withOpacity(0.5),
          },
          overlayWidgetBuilder: (_) {
            return const SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: LinearProgressIndicator(),
              ),
            );
          },
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: AppTheme.generateThemeData(
              colorScheme: lightColorScheme,
              brightness: Brightness.light,
            ),
            darkTheme: AppTheme.generateThemeData(
              colorScheme: darkColorScheme,
              brightness: Brightness.dark,
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: _appRouter.config(
              navigatorObservers: () => [
                getIt<AppAutoRouteObserver>(),
              ],
            ),
          ),
        );
      },
    );
  }
}
