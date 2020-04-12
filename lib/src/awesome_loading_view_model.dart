import 'package:flutter/material.dart';

/// Singleton
/// AwesomeLoadingViewModel
///
class AwesomeLoadingViewModel extends ChangeNotifier {
  /// Instance
  static AwesomeLoadingViewModel _instance;

  /// Constructor
  AwesomeLoadingViewModel._();

  /// GetInstance
  static getInstance() {
    if (_instance == null) {
      _instance = AwesomeLoadingViewModel._();
    }
    return _instance;
  }

  /// ReleaseInstance
  static releaseInstance() {
    _instance = null;
  }

  /// Notify
  void notify() {
    notifyListeners();
  }
}
