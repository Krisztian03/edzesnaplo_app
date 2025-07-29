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

  @override
  String get firstName => 'Keresztnév';

  @override
  String get firstNameEmptyError => 'Kérlek add meg a keresztneved';

  @override
  String homeGreeting(Object name) {
    return 'Szia, $name';
  }

  @override
  String get steps => 'Lépések';

  @override
  String get sleep => 'Alvás';

  @override
  String get water => 'Víz';

  @override
  String get heartRate => 'Heart rate';

  @override
  String get cycling => 'Biciklizés';

  @override
  String get calories => 'Kalória';

  @override
  String get home => 'Főoldal';

  @override
  String get training => 'Edzés';

  @override
  String get exercises => 'Gyakorlatok';

  @override
  String get report => 'Riport';

  @override
  String get profile => 'Profil';

  @override
  String get logout => 'Kijelentkezés';

  @override
  String get firstNameInvalidError =>
      'Csak ékezetes vagy angol betűk lehetnek!';

  @override
  String get addTraining => 'Edzés hozzáadása';

  @override
  String get selectCategory => 'Válassz kategóriát';

  @override
  String get selectExercise => 'Válassz gyakorlatot';

  @override
  String get addWorkout => 'Edzés hozzáadása';

  @override
  String get chooseCategory => 'Válassz kategóriát';

  @override
  String get chest => 'Mell';

  @override
  String get back => 'Hát';

  @override
  String get legs => 'Láb';

  @override
  String get arms => 'Kar';

  @override
  String get benchPress => 'Fekvenyomás';

  @override
  String get pushUps => 'Fekvőtámasz';

  @override
  String get pullUps => 'Húzódzkodás';

  @override
  String get squats => 'Guggolás';

  @override
  String get bicepCurls => 'Bicepsz hajlítás';

  @override
  String get sets => 'Sorozatok';

  @override
  String get reps => 'Ismétlések';

  @override
  String get weightOptional => 'Súly (opcionális)';

  @override
  String get save => 'Mentés';

  @override
  String get close => 'Bezárás';
}
