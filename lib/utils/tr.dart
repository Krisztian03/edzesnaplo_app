import 'package:flutter/widgets.dart';

import '../l10n/app_localizations.dart';

/// A localization helper to get a string from AppLocalizations
/// based on the ARB key. Returns the key itself as fallback.
String tr(BuildContext context, String key) {
  final loc = AppLocalizations.of(context)!;

  switch (key) {
  // General
    case 'login': return loc.login;
    case 'email': return loc.email;
    case 'password': return loc.password;
    case 'register': return loc.register;
    case 'firstName': return loc.firstName;
    case 'confirmPassword': return loc.confirmPassword;
    case 'home': return loc.home;
    case 'training': return loc.training;
    case 'exercises': return loc.exercises;
    case 'report': return loc.report;
    case 'profile': return loc.profile;
    case 'addWorkout': return loc.addWorkout;
    case 'chooseCategory': return loc.chooseCategory;
    case 'noWorkouts': return loc.noWorkouts;
    case 'loadTemplate': return loc.loadTemplate;
    case 'close': return loc.close;
    case 'selectCategory': return loc.selectCategory;
    case 'selectExercise': return loc.selectExercise;

  // Categories
    case 'chest': return loc.chest;
    case 'back': return loc.back;
    case 'legs': return loc.legs;
    case 'arms': return loc.arms;
    case 'shoulders': return loc.shoulders;
    case 'core': return loc.core;
    case 'cardio': return loc.cardio;

  // Chest exercises
    case 'benchPress': return loc.benchPress;
    case 'inclineBenchPress': return loc.inclineBenchPress;
    case 'declineBenchPress': return loc.declineBenchPress;
    case 'chestFly': return loc.chestFly;
    case 'pushUps': return loc.pushUps;
    case 'cableCrossover': return loc.cableCrossover;
    case 'dips': return loc.dips;

  // Back exercises
    case 'pullUps': return loc.pullUps;
    case 'chinUps': return loc.chinUps;
    case 'barbellRow': return loc.barbellRow;
    case 'dumbbellRow': return loc.dumbbellRow;
    case 'latPulldown': return loc.latPulldown;
    case 'deadlift': return loc.deadlift;
    case 'facePull': return loc.facePull;
    case 'tBarRow': return loc.tBarRow;

  // Legs exercises
    case 'squats': return loc.squats;
    case 'frontSquats': return loc.frontSquats;
    case 'lunges': return loc.lunges;
    case 'stepUps': return loc.stepUps;
    case 'legPress': return loc.legPress;
    case 'romanianDeadlift': return loc.romanianDeadlift;
    case 'legExtension': return loc.legExtension;
    case 'hamstringCurl': return loc.hamstringCurl;
    case 'calfRaise': return loc.calfRaise;

  // Arms exercises
    case 'bicepCurls': return loc.bicepCurls;
    case 'hammerCurls': return loc.hammerCurls;
    case 'concentrationCurl': return loc.concentrationCurl;
    case 'tricepPushdown': return loc.tricepPushdown;
    case 'tricepDips': return loc.tricepDips;
    case 'skullCrushers': return loc.skullCrushers;
    case 'overheadTricepExtension': return loc.overheadTricepExtension;
    case 'closeGripBenchPress': return loc.closeGripBenchPress;

  // Shoulders exercises
    case 'shoulderPress': return loc.shoulderPress;
    case 'lateralRaise': return loc.lateralRaise;
    case 'frontRaise': return loc.frontRaise;
    case 'rearDeltFly': return loc.rearDeltFly;
    case 'arnoldPress': return loc.arnoldPress;
    case 'shrugs': return loc.shrugs;
    case 'uprightRow': return loc.uprightRow;

  // Core exercises
    case 'plank': return loc.plank;
    case 'crunches': return loc.crunches;
    case 'legRaises': return loc.legRaises;
    case 'russianTwist': return loc.russianTwist;
    case 'bicycleCrunch': return loc.bicycleCrunch;
    case 'mountainClimbers': return loc.mountainClimbers;
    case 'hangingLegRaise': return loc.hangingLegRaise;
    case 'abRollout': return loc.abRollout;

  // Cardio exercises
    case 'running': return loc.running;
    case 'cycling': return loc.cycling;
    case 'rowing': return loc.rowing;
    case 'jumpRope': return loc.jumpRope;
    case 'stairClimber': return loc.stairClimber;
    case 'elliptical': return loc.elliptical;
    case 'swimming': return loc.swimming;
    case 'hiit': return loc.hiit;

  // Days short
    case 'mondayShort': return loc.mondayShort;
    case 'tuesdayShort': return loc.tuesdayShort;
    case 'wednesdayShort': return loc.wednesdayShort;
    case 'thursdayShort': return loc.thursdayShort;
    case 'fridayShort': return loc.fridayShort;
    case 'saturdayShort': return loc.saturdayShort;
    case 'sundayShort': return loc.sundayShort;

    default: return key; // fallback
  }
}
