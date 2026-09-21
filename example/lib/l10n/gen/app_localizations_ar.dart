// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'عرض الإعدادات';

  @override
  String greeting(String name) {
    return 'مرحبًا، $name!';
  }

  @override
  String get themeSectionTitle => 'المظهر';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get seedColorLabel => 'لون الأساس';

  @override
  String get languageSectionTitle => 'اللغة';

  @override
  String get languageSystemDefault => 'افتراضي النظام';

  @override
  String get textSizeSectionTitle => 'حجم النص';

  @override
  String get textSizePreview => 'نص تجريبي لمعاينة حجم الخط في هذا التطبيق.';

  @override
  String get aboutSectionTitle => 'حول';

  @override
  String appVersionLabel(String version, String buildNumber) {
    return 'الإصدار $version ($buildNumber)';
  }

  @override
  String platformLabel(String platform) {
    return 'المنصة: $platform';
  }

  @override
  String get privacySectionTitle => 'الخصوصية';

  @override
  String get analyticsToggleLabel => 'إرسال إحصاءات مجهولة';

  @override
  String get analyticsToggleHelper => 'إعداد الجهاز — يبقى بعد تسجيل الخروج.';

  @override
  String get hideBalancesToggleLabel => 'إخفاء أرصدة الحساب';

  @override
  String get hideBalancesToggleHelper =>
      'إعداد الحساب — يُمسح عند تسجيل الخروج.';

  @override
  String get accountSectionTitle => 'الحساب';

  @override
  String get logOutButton => 'تسجيل الخروج';

  @override
  String get resetAppButton => 'إعادة ضبط التطبيق';

  @override
  String get firstLaunchWelcomeTitle => 'أهلًا بك!';

  @override
  String get firstLaunchWelcomeBody => 'يظهر هذا الشريط فقط عند أول تشغيل.';

  @override
  String get firstLaunchDismiss => 'حسنًا';
}
