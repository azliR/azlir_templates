import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name}}/app/generated/assets.gen.dart';
import 'package:{{project_name}}/features/settings/providers/settings/settings_provider.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:package_info_plus/package_info_plus.dart';

@RoutePage()
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeNotifierProvider);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar.large(
            title: Text('Settings'),
          ),
        ],
        body: ListView(
          padding:
              const EdgeInsets.fromLTRB(0, 0, 0, kBottomNavigationBarHeight),
          children: [
            ListTile(
              title: const Text('Theme'),
              subtitle: Text(
                switch (themeMode) {
                  ThemeMode.system => 'System',
                  ThemeMode.light => 'Light theme',
                  ThemeMode.dark => 'Dark theme',
                },
              ),
              leading: const Icon(Symbols.light_mode_rounded),
              trailing: const Icon(Symbols.chevron_right_rounded),
              onTap: _showSelectThemeDialog,
            ),
            const Divider(),
            ListTile(
              title: const Text('About this app'),
              leading: const Icon(Symbols.info_rounded),
              onTap: () async {
                final packageInfo = await PackageInfo.fromPlatform();

                if (!context.mounted) return;

                showAboutDialog(
                  context: context,
                  applicationIcon: Image(
                    image: Assets.icons.adaptiveLauncherIcon.provider(),
                    width: 48,
                    height: 48,
                  ),
                  applicationName: packageInfo.appName,
                  applicationVersion: packageInfo.version,
                  applicationLegalese: '© 2023 azliR',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showSelectThemeDialog() async {
    final selectedThemeMode = ref.read(themeModeNotifierProvider);

    return showModal(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Select theme'),
          children: ThemeMode.values.map((themeMode) {
            return RadioListTile(
              title: Text(
                switch (themeMode) {
                  ThemeMode.system => 'System',
                  ThemeMode.light => 'Light theme',
                  ThemeMode.dark => 'Dark theme',
                },
              ),
              value: themeMode,
              groupValue: selectedThemeMode,
              onChanged: (value) {
                Navigator.pop(context);
                ref
                    .read(themeModeNotifierProvider.notifier)
                    .setTheme(themeMode);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
