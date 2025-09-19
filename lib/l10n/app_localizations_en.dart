// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get register => 'Register';

  @override
  String get emailEmptyError => 'Email cannot be empty';

  @override
  String get passwordShortError => 'Password must be at least 6 characters';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get firstName => 'First Name';

  @override
  String get firstNameEmptyError => 'Please enter your first name';

  @override
  String homeGreeting(Object name) {
    return 'Hello, $name';
  }

  @override
  String get steps => 'Steps';

  @override
  String get sleep => 'Sleep';

  @override
  String get water => 'Water';

  @override
  String get heartRate => 'Heart rate';

  @override
  String get cycling => 'Cycling';

  @override
  String get calories => 'Calories';

  @override
  String get home => 'Home';

  @override
  String get training => 'Training';

  @override
  String get exercises => 'Exercises';

  @override
  String get report => 'Report';

  @override
  String get profile => 'Profile';

  @override
  String get statusWalking => 'Walking';

  @override
  String get statusStopped => 'Stopped';

  @override
  String get mondayShort => 'Mon';

  @override
  String get tuesdayShort => 'Tue';

  @override
  String get wednesdayShort => 'Wed';

  @override
  String get thursdayShort => 'Thu';

  @override
  String get fridayShort => 'Fri';

  @override
  String get saturdayShort => 'Sat';

  @override
  String get sundayShort => 'Sun';

  @override
  String get stepCounterError => ' Step Counter Error!';

  @override
  String get pedestrianStatusError => 'Pedestrian Status error!';

  @override
  String get invalidAmount => 'Please enter a valid amount!';

  @override
  String get maxPerServingExceeded => 'You can add up to 5 liters per serving!';

  @override
  String get dailyLimitExceeded =>
      'You’ve reached the daily limit (10 liters)!';

  @override
  String get waterIntake => 'Water intake';

  @override
  String get enterWaterAmount => 'Enter amount in ml';

  @override
  String get waterAddedSuccess => 'Water Added';

  @override
  String get add => 'Add';

  @override
  String get close => 'Close';

  @override
  String get logout => 'Log out';

  @override
  String get firstNameInvalidError =>
      'Only letters with or without accents are allowed!';

  @override
  String get addTraining => 'Add training';

  @override
  String get noWorkouts => 'There are no scheduled workouts for this day.';

  @override
  String get selectCategory => 'Select category';

  @override
  String get selectExercise => 'Select exercise';

  @override
  String get addWorkout => 'Add Workout';

  @override
  String get chooseCategory => 'Choose a category';

  @override
  String get chest => 'Chest';

  @override
  String get back => 'Back';

  @override
  String get legs => 'Legs';

  @override
  String get arms => 'Arms';

  @override
  String get benchPress => 'Bench Press';

  @override
  String get pushUps => 'Push-ups';

  @override
  String get pullUps => 'Pull-ups';

  @override
  String get squats => 'Squats';

  @override
  String get bicepCurls => 'Bicep curls';

  @override
  String get sets => 'Sets';

  @override
  String get reps => 'Reps';

  @override
  String get weightOptional => 'Weight (optional)';

  @override
  String get save => 'Save';
}
