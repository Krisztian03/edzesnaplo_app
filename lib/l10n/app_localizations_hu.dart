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
  String get register => 'Regisztráció';

  @override
  String get emailEmptyError => 'Az email nem lehet üres';

  @override
  String get passwordShortError =>
      'A jelszónak legalább 6 karakter hosszúnak kell lennie';

  @override
  String get alreadyHaveAccount => 'Már van fiókod?';

  @override
  String get dontHaveAccount => 'Még nincs fiókod?';

  @override
  String get confirmPassword => 'Jelszó megerősítése';

  @override
  String get passwordsDoNotMatch => 'A jelszavak nem egyeznek';
}
