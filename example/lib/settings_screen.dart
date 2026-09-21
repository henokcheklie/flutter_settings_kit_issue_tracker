import 'package:flutter/material.dart';
import 'package:flutter_settings_kit/flutter_settings_kit.dart';

import 'l10n/gen/app_localizations.dart';

const _languages = <(Locale, String)>[
  (Locale('en'), 'English'),
  (Locale('fr'), 'Français'),
  (Locale('ar'), 'العربية'),
  (Locale('am'), 'አማርኛ'),
  (Locale('ti'), 'ትግርኛ'),
  (Locale('om'), 'Afaan Oromoo'),
  (Locale('so'), 'Soomaali'),
];

/// The single settings screen this example builds, pulling every module
/// together. [seedColor], [firstLaunch], [analyticsOptIn], and
/// [hideBalances] are plain `SettingController`s (not scoped) passed in
/// directly, showing that not every setting needs its own scope widget
/// — theme/locale/text-scale/app-info are read via `.of(context)`
/// instead, since [SettingsDemoApp] wraps this screen in their scopes.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    required this.seedColor,
    required this.firstLaunch,
    required this.analyticsOptIn,
    required this.hideBalances,
    super.key,
  });

  final SettingController<Color> seedColor;
  final FirstLaunchController firstLaunch;
  final SettingController<bool> analyticsOptIn;
  final SettingController<bool> hideBalances;

  List<SettingController<Object?>> _allSettings(BuildContext context) => [
    ThemeScope.of(context),
    LocaleScope.of(context),
    TextScaleScope.of(context),
    seedColor,
    firstLaunch,
    analyticsOptIn,
    hideBalances,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _FirstLaunchBanner(firstLaunch: firstLaunch, l10n: l10n),
          _SectionCard(
            title: l10n.themeSectionTitle,
            child: _ThemeSection(seedColor: seedColor, l10n: l10n),
          ),
          _SectionCard(
            title: l10n.languageSectionTitle,
            child: _LanguageSection(l10n: l10n),
          ),
          _SectionCard(
            title: l10n.textSizeSectionTitle,
            child: _TextScaleSection(l10n: l10n),
          ),
          _SectionCard(
            title: l10n.aboutSectionTitle,
            child: const _AboutSection(),
          ),
          _SectionCard(
            title: l10n.privacySectionTitle,
            child: _PrivacySection(
              analyticsOptIn: analyticsOptIn,
              hideBalances: hideBalances,
              l10n: l10n,
            ),
          ),
          _SectionCard(
            title: l10n.accountSectionTitle,
            child: _AccountSection(
              l10n: l10n,
              allSettings: () => _allSettings(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _FirstLaunchBanner extends StatelessWidget {
  const _FirstLaunchBanner({required this.firstLaunch, required this.l10n});

  final FirstLaunchController firstLaunch;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: firstLaunch,
      builder: (context, _) {
        if (!firstLaunch.isFirstLaunch) {
          return const SizedBox.shrink();
        }
        final colorScheme = Theme.of(context).colorScheme;
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          color: colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.firstLaunchWelcomeTitle,
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(color: colorScheme.onPrimaryContainer),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.firstLaunchWelcomeBody,
                  style: TextStyle(color: colorScheme.onPrimaryContainer),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: firstLaunch.markLaunched,
                    child: Text(l10n.firstLaunchDismiss),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ThemeSection extends StatelessWidget {
  const _ThemeSection({required this.seedColor, required this.l10n});

  final SettingController<Color> seedColor;
  final AppLocalizations l10n;

  static const _swatches = [
    Colors.teal,
    Colors.indigo,
    Colors.deepOrange,
    Colors.pink,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    final theme = ThemeScope.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SegmentedButton<ThemeMode>(
          segments: [
            ButtonSegment(
              value: ThemeMode.system,
              label: Text(l10n.themeSystem),
            ),
            ButtonSegment(value: ThemeMode.light, label: Text(l10n.themeLight)),
            ButtonSegment(value: ThemeMode.dark, label: Text(l10n.themeDark)),
          ],
          selected: {theme.themeMode},
          onSelectionChanged: (selection) =>
              theme.setThemeMode(selection.first),
        ),
        const SizedBox(height: 12),
        Text(l10n.seedColorLabel),
        const SizedBox(height: 8),
        ListenableBuilder(
          listenable: seedColor,
          builder: (context, _) {
            return Row(
              children: [
                for (final swatch in _swatches)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => seedColor.update(swatch),
                      child: CircleAvatar(
                        backgroundColor: swatch,
                        child: seedColor.value.toARGB32() == swatch.toARGB32()
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _LanguageSection extends StatelessWidget {
  const _LanguageSection({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final locale = LocaleScope.of(context);

    return DropdownButton<Locale?>(
      isExpanded: true,
      value: locale.locale,
      items: [
        DropdownMenuItem(value: null, child: Text(l10n.languageSystemDefault)),
        for (final (languageLocale, label) in _languages)
          DropdownMenuItem(value: languageLocale, child: Text(label)),
      ],
      onChanged: locale.setLocale,
    );
  }
}

class _TextScaleSection extends StatelessWidget {
  const _TextScaleSection({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final textScale = TextScaleScope.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Slider(
          value: textScale.textScale,
          min: textScale.minScale,
          max: textScale.maxScale,
          divisions: 8,
          label: textScale.textScale.toStringAsFixed(2),
          onChanged: textScale.setTextScale,
        ),
        Text(l10n.textSizePreview),
      ],
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appInfo = AppInfoScope.of(context);

    return FutureBuilder<AppInfo>(
      future: appInfo.load(),
      builder: (context, snapshot) {
        final info = snapshot.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (info == null)
              const LinearProgressIndicator()
            else ...[
              Text(info.appName, style: Theme.of(context).textTheme.titleSmall),
              Text(l10n.appVersionLabel(info.version, info.buildNumber)),
            ],
            const SizedBox(height: 4),
            Text(l10n.platformLabel(appInfo.platform.name)),
          ],
        );
      },
    );
  }
}

class _PrivacySection extends StatelessWidget {
  const _PrivacySection({
    required this.analyticsOptIn,
    required this.hideBalances,
    required this.l10n,
  });

  final SettingController<bool> analyticsOptIn;
  final SettingController<bool> hideBalances;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListenableBuilder(
          listenable: analyticsOptIn,
          builder: (context, _) => SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.analyticsToggleLabel),
            subtitle: Text(l10n.analyticsToggleHelper),
            value: analyticsOptIn.value,
            onChanged: analyticsOptIn.update,
          ),
        ),
        ListenableBuilder(
          listenable: hideBalances,
          builder: (context, _) => SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.hideBalancesToggleLabel),
            subtitle: Text(l10n.hideBalancesToggleHelper),
            value: hideBalances.value,
            onChanged: hideBalances.update,
          ),
        ),
      ],
    );
  }
}

class _AccountSection extends StatelessWidget {
  const _AccountSection({required this.l10n, required this.allSettings});

  final AppLocalizations l10n;
  final List<SettingController<Object?>> Function() allSettings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () async {
              await resetSession(allSettings());
              if (!context.mounted) return;
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(l10n.logOutButton)));
            },
            child: Text(l10n.logOutButton),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FilledButton.tonal(
            onPressed: () async {
              await resetAll(allSettings());
              if (!context.mounted) return;
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(l10n.resetAppButton)));
            },
            child: Text(l10n.resetAppButton),
          ),
        ),
      ],
    );
  }
}
