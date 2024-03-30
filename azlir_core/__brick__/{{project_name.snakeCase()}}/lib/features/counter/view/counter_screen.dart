import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name}}/app/l10n/l10n.dart';
import 'package:{{project_name}}/app/themes/app_spacing.dart';
import 'package:{{project_name}}/features/counter/counter.dart';
import 'package:material_symbols_icons/symbols.dart';

@RoutePage()
class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar.large(
            title: Text(l10n.counterAppBarTitle),
            actions: [
              _buildMenuActions(),
            ],
          ),
        ],
        body: Column(
          children: [
            const _CounterText(),
            const Gap(Insets.xsmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.tonal(
                  onPressed: () =>
                      ref.read(counterNotifierProvider.notifier).decrement(),
                  child: const Icon(Symbols.remove),
                ),
                const Gap(Insets.medium),
                FilledButton.tonal(
                  onPressed: () =>
                      ref.read(counterNotifierProvider.notifier).increment(),
                  child: const Icon(Symbols.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuActions() {
    return MenuAnchor(
      builder: (context, controller, child) {
        return IconButton(
          icon: const Icon(Symbols.more_vert_rounded),
          onPressed: () =>
              controller.isOpen ? controller.close() : controller.open(),
        );
      },
      menuChildren: [
        MenuItemButton(
          onPressed: () {},
          child: const Text('Reset'),
        ),
      ],
    );
  }
}

class _CounterText extends ConsumerWidget {
  const _CounterText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final count = ref.watch(counterNotifierProvider);
    return Text('$count', style: theme.textTheme.displayLarge);
  }
}
