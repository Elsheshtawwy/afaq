import 'package:flutter/material.dart';

class BaseProvider with ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

   setBusy(bool value) {
    if (_busy != value) {
      _busy = value;
      notifyListeners();
    }
  }
}
