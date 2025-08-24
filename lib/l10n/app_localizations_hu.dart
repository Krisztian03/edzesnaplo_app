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
  String get statusWalking => 'Sétál';

  @override
  String get statusStopped => 'Áll';

  @override
  String get mondayShort => 'Hét';

  @override
  String get tuesdayShort => 'Kedd';

  @override
  String get wednesdayShort => 'Sze';

  @override
  String get thursdayShort => 'Csüt';

  @override
  String get fridayShort => 'Pén';

  @override
  String get saturdayShort => 'Szo';

  @override
  String get sundayShort => 'Vas';

  @override
  String get stepCounterError => 'Lépésszámláló hiba!';

  @override
  String get pedestrianStatusError => 'Lépésszámláló státusz hiba!';

  @override
  String get invalidAmount => 'Adj meg egy érvényes mennyiséget!';

  @override
  String get maxPerServingExceeded =>
      'Egyszerre legfeljebb 5 liter adható hozzá!';

  @override
  String get dailyLimitExceeded => 'Elérted a napi maximumot (10 liter)!';

  @override
  String get waterIntake => 'Vízfogyasztás';

  @override
  String get enterWaterAmount => 'Add meg a mennyiséget (ml)';

  @override
  String get waterAddedSuccess => 'Sikeresen hozzáadva!';

  @override
  String get add => 'Hozzáadás';

  @override
  String get close => 'Bezárás';

  @override
  String get logout => 'Kijelentkezés';

  @override
  String get firstNameInvalidError =>
      'Csak ékezetes vagy angol betűk lehetnek!';

  @override
  String get addTraining => 'Edzés hozzáadása';

  @override
  String get noWorkouts => 'Nincs rögzített edzés erre a napra.';

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
}
