// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get login => 'Bejelentkezés';

  @override
  String get email => 'Email';

  @override
  String get password => 'Jelszó';

  @override
  String get emailEmptyError => 'Kérlek add meg az emailed!';

  @override
  String get passwordShortError => 'Minimum 6 karakteres jelszó kell!';
}
