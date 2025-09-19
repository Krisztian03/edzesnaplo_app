import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hu.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hu'),
  ];

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @emailEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be empty'**
  String get emailEmptyError;

  /// No description provided for @passwordShortError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordShortError;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @firstNameEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your first name'**
  String get firstNameEmptyError;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String homeGreeting(Object name);

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get steps;

  /// No description provided for @sleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get sleep;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @heartRate.
  ///
  /// In en, this message translates to:
  /// **'Heart rate'**
  String get heartRate;

  /// No description provided for @calories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get calories;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @training.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get training;

  /// No description provided for @exercises.
  ///
  /// In en, this message translates to:
  /// **'Exercises'**
  String get exercises;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @statusWalking.
  ///
  /// In en, this message translates to:
  /// **'Walking'**
  String get statusWalking;

  /// No description provided for @statusStopped.
  ///
  /// In en, this message translates to:
  /// **'Stopped'**
  String get statusStopped;

  /// No description provided for @mondayShort.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get mondayShort;

  /// No description provided for @tuesdayShort.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tuesdayShort;

  /// No description provided for @wednesdayShort.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wednesdayShort;

  /// No description provided for @thursdayShort.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thursdayShort;

  /// No description provided for @fridayShort.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get fridayShort;

  /// No description provided for @saturdayShort.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get saturdayShort;

  /// No description provided for @sundayShort.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sundayShort;

  /// No description provided for @stepCounterError.
  ///
  /// In en, this message translates to:
  /// **' Step Counter Error!'**
  String get stepCounterError;

  /// No description provided for @pedestrianStatusError.
  ///
  /// In en, this message translates to:
  /// **'Pedestrian Status error!'**
  String get pedestrianStatusError;

  /// No description provided for @invalidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount!'**
  String get invalidAmount;

  /// No description provided for @maxPerServingExceeded.
  ///
  /// In en, this message translates to:
  /// **'You can add up to 5 liters per serving!'**
  String get maxPerServingExceeded;

  /// No description provided for @dailyLimitExceeded.
  ///
  /// In en, this message translates to:
  /// **'You’ve reached the daily limit (10 liters)!'**
  String get dailyLimitExceeded;

  /// No description provided for @waterIntake.
  ///
  /// In en, this message translates to:
  /// **'Water intake'**
  String get waterIntake;

  /// No description provided for @enterWaterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter amount in ml'**
  String get enterWaterAmount;

  /// No description provided for @waterAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Water Added'**
  String get waterAddedSuccess;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @firstNameInvalidError.
  ///
  /// In en, this message translates to:
  /// **'Only letters with or without accents are allowed!'**
  String get firstNameInvalidError;

  /// No description provided for @addTraining.
  ///
  /// In en, this message translates to:
  /// **'Add training'**
  String get addTraining;

  /// No description provided for @noWorkouts.
  ///
  /// In en, this message translates to:
  /// **'There are no scheduled workouts for this day.'**
  String get noWorkouts;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select category'**
  String get selectCategory;

  /// No description provided for @selectExercise.
  ///
  /// In en, this message translates to:
  /// **'Select exercise'**
  String get selectExercise;

  /// No description provided for @addWorkout.
  ///
  /// In en, this message translates to:
  /// **'Add Workout'**
  String get addWorkout;

  /// No description provided for @chooseCategory.
  ///
  /// In en, this message translates to:
  /// **'Choose a category'**
  String get chooseCategory;

  /// No description provided for @chest.
  ///
  /// In en, this message translates to:
  /// **'Chest'**
  String get chest;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @legs.
  ///
  /// In en, this message translates to:
  /// **'Legs'**
  String get legs;

  /// No description provided for @arms.
  ///
  /// In en, this message translates to:
  /// **'Arms'**
  String get arms;

  /// No description provided for @shoulders.
  ///
  /// In en, this message translates to:
  /// **'Shoulders'**
  String get shoulders;

  /// No description provided for @core.
  ///
  /// In en, this message translates to:
  /// **'Core'**
  String get core;

  /// No description provided for @cardio.
  ///
  /// In en, this message translates to:
  /// **'Cardio'**
  String get cardio;

  /// No description provided for @benchPress.
  ///
  /// In en, this message translates to:
  /// **'Bench Press'**
  String get benchPress;

  /// No description provided for @inclineBenchPress.
  ///
  /// In en, this message translates to:
  /// **'Incline Bench Press'**
  String get inclineBenchPress;

  /// No description provided for @declineBenchPress.
  ///
  /// In en, this message translates to:
  /// **'Decline Bench Press'**
  String get declineBenchPress;

  /// No description provided for @chestFly.
  ///
  /// In en, this message translates to:
  /// **'Chest Fly'**
  String get chestFly;

  /// No description provided for @pushUps.
  ///
  /// In en, this message translates to:
  /// **'Push Ups'**
  String get pushUps;

  /// No description provided for @cableCrossover.
  ///
  /// In en, this message translates to:
  /// **'Cable Crossover'**
  String get cableCrossover;

  /// No description provided for @dips.
  ///
  /// In en, this message translates to:
  /// **'Dips'**
  String get dips;

  /// No description provided for @pullUps.
  ///
  /// In en, this message translates to:
  /// **'Pull Ups'**
  String get pullUps;

  /// No description provided for @chinUps.
  ///
  /// In en, this message translates to:
  /// **'Chin Ups'**
  String get chinUps;

  /// No description provided for @barbellRow.
  ///
  /// In en, this message translates to:
  /// **'Barbell Row'**
  String get barbellRow;

  /// No description provided for @dumbbellRow.
  ///
  /// In en, this message translates to:
  /// **'Dumbbell Row'**
  String get dumbbellRow;

  /// No description provided for @latPulldown.
  ///
  /// In en, this message translates to:
  /// **'Lat Pulldown'**
  String get latPulldown;

  /// No description provided for @deadlift.
  ///
  /// In en, this message translates to:
  /// **'Deadlift'**
  String get deadlift;

  /// No description provided for @facePull.
  ///
  /// In en, this message translates to:
  /// **'Face Pull'**
  String get facePull;

  /// No description provided for @tBarRow.
  ///
  /// In en, this message translates to:
  /// **'T-Bar Row'**
  String get tBarRow;

  /// No description provided for @squats.
  ///
  /// In en, this message translates to:
  /// **'Squats'**
  String get squats;

  /// No description provided for @frontSquats.
  ///
  /// In en, this message translates to:
  /// **'Front Squats'**
  String get frontSquats;

  /// No description provided for @lunges.
  ///
  /// In en, this message translates to:
  /// **'Lunges'**
  String get lunges;

  /// No description provided for @stepUps.
  ///
  /// In en, this message translates to:
  /// **'Step Ups'**
  String get stepUps;

  /// No description provided for @legPress.
  ///
  /// In en, this message translates to:
  /// **'Leg Press'**
  String get legPress;

  /// No description provided for @romanianDeadlift.
  ///
  /// In en, this message translates to:
  /// **'Romanian Deadlift'**
  String get romanianDeadlift;

  /// No description provided for @legExtension.
  ///
  /// In en, this message translates to:
  /// **'Leg Extension'**
  String get legExtension;

  /// No description provided for @hamstringCurl.
  ///
  /// In en, this message translates to:
  /// **'Hamstring Curl'**
  String get hamstringCurl;

  /// No description provided for @calfRaise.
  ///
  /// In en, this message translates to:
  /// **'Calf Raise'**
  String get calfRaise;

  /// No description provided for @bicepCurls.
  ///
  /// In en, this message translates to:
  /// **'Bicep Curls'**
  String get bicepCurls;

  /// No description provided for @hammerCurls.
  ///
  /// In en, this message translates to:
  /// **'Hammer Curls'**
  String get hammerCurls;

  /// No description provided for @concentrationCurl.
  ///
  /// In en, this message translates to:
  /// **'Concentration Curl'**
  String get concentrationCurl;

  /// No description provided for @tricepPushdown.
  ///
  /// In en, this message translates to:
  /// **'Tricep Pushdown'**
  String get tricepPushdown;

  /// No description provided for @tricepDips.
  ///
  /// In en, this message translates to:
  /// **'Tricep Dips'**
  String get tricepDips;

  /// No description provided for @skullCrushers.
  ///
  /// In en, this message translates to:
  /// **'Skull Crushers'**
  String get skullCrushers;

  /// No description provided for @overheadTricepExtension.
  ///
  /// In en, this message translates to:
  /// **'Overhead Tricep Extension'**
  String get overheadTricepExtension;

  /// No description provided for @closeGripBenchPress.
  ///
  /// In en, this message translates to:
  /// **'Close Grip Bench Press'**
  String get closeGripBenchPress;

  /// No description provided for @shoulderPress.
  ///
  /// In en, this message translates to:
  /// **'Shoulder Press'**
  String get shoulderPress;

  /// No description provided for @lateralRaise.
  ///
  /// In en, this message translates to:
  /// **'Lateral Raise'**
  String get lateralRaise;

  /// No description provided for @frontRaise.
  ///
  /// In en, this message translates to:
  /// **'Front Raise'**
  String get frontRaise;

  /// No description provided for @rearDeltFly.
  ///
  /// In en, this message translates to:
  /// **'Rear Delt Fly'**
  String get rearDeltFly;

  /// No description provided for @arnoldPress.
  ///
  /// In en, this message translates to:
  /// **'Arnold Press'**
  String get arnoldPress;

  /// No description provided for @shrugs.
  ///
  /// In en, this message translates to:
  /// **'Shrugs'**
  String get shrugs;

  /// No description provided for @uprightRow.
  ///
  /// In en, this message translates to:
  /// **'Upright Row'**
  String get uprightRow;

  /// No description provided for @plank.
  ///
  /// In en, this message translates to:
  /// **'Plank'**
  String get plank;

  /// No description provided for @crunches.
  ///
  /// In en, this message translates to:
  /// **'Crunches'**
  String get crunches;

  /// No description provided for @legRaises.
  ///
  /// In en, this message translates to:
  /// **'Leg Raises'**
  String get legRaises;

  /// No description provided for @russianTwist.
  ///
  /// In en, this message translates to:
  /// **'Russian Twist'**
  String get russianTwist;

  /// No description provided for @bicycleCrunch.
  ///
  /// In en, this message translates to:
  /// **'Bicycle Crunch'**
  String get bicycleCrunch;

  /// No description provided for @mountainClimbers.
  ///
  /// In en, this message translates to:
  /// **'Mountain Climbers'**
  String get mountainClimbers;

  /// No description provided for @hangingLegRaise.
  ///
  /// In en, this message translates to:
  /// **'Hanging Leg Raise'**
  String get hangingLegRaise;

  /// No description provided for @abRollout.
  ///
  /// In en, this message translates to:
  /// **'Ab Rollout'**
  String get abRollout;

  /// No description provided for @running.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get running;

  /// No description provided for @cycling.
  ///
  /// In en, this message translates to:
  /// **'Cycling'**
  String get cycling;

  /// No description provided for @rowing.
  ///
  /// In en, this message translates to:
  /// **'Rowing'**
  String get rowing;

  /// No description provided for @jumpRope.
  ///
  /// In en, this message translates to:
  /// **'Jump Rope'**
  String get jumpRope;

  /// No description provided for @stairClimber.
  ///
  /// In en, this message translates to:
  /// **'Stair Climber'**
  String get stairClimber;

  /// No description provided for @elliptical.
  ///
  /// In en, this message translates to:
  /// **'Elliptical'**
  String get elliptical;

  /// No description provided for @swimming.
  ///
  /// In en, this message translates to:
  /// **'Swimming'**
  String get swimming;

  /// No description provided for @hiit.
  ///
  /// In en, this message translates to:
  /// **'HIIT'**
  String get hiit;

  /// No description provided for @sets.
  ///
  /// In en, this message translates to:
  /// **'Sets'**
  String get sets;

  /// No description provided for @reps.
  ///
  /// In en, this message translates to:
  /// **'Reps'**
  String get reps;

  /// No description provided for @weightOptional.
  ///
  /// In en, this message translates to:
  /// **'Weight (optional)'**
  String get weightOptional;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @loadTemplate.
  ///
  /// In en, this message translates to:
  /// **'Load template'**
  String get loadTemplate;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hu'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hu':
      return AppLocalizationsHu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
