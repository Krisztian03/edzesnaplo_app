import 'package:pedometer/pedometer.dart';
import 'dart:async';

class StepTrackerService {
  final _stepCountController = StreamController<int>.broadcast();
  final _statusController = StreamController<String>.broadcast();

  Stream<int> get stepCountStream => _stepCountController.stream;
  Stream<String> get statusStream => _statusController.stream;

  StepCount? _lastStep;
  PedestrianStatus? _lastStatus;

  late String Function(String key) _localize;

  void init({required String Function(String key) localize}) {
    _localize = localize;

    // Step count stream
    Pedometer.stepCountStream.listen((StepCount event) {
      _lastStep = event;
      _stepCountController.add(event.steps);
    }, onError: (error) {
      _stepCountController.addError("${_localize("stepCounterError")}: $error");
    });

    // Status stream
    Pedometer.pedestrianStatusStream.listen((PedestrianStatus status) {
      _lastStatus = status;
      _statusController.add(status.status);
    }, onError: (error) {
      _statusController.addError("${_localize("pedestrianStatusError")}: $error");
    });
  }

  void dispose() {
    _stepCountController.close();
    _statusController.close();
  }
}
