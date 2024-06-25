import 'package:flutter/material.dart';

class DriveButtonViewModel extends ChangeNotifier {
  bool _isDriving = false;

  bool get isDriving => _isDriving;

  void toggleDriving() {
    _isDriving = !_isDriving;
    notifyListeners();
  }

  void startDriving() {
    _isDriving = true;
    notifyListeners();
  }

  void stopDriving() {
    _isDriving = false;
    notifyListeners();
  }
}
