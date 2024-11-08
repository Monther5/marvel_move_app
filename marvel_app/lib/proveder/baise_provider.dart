import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marvel_app/serves/api.dart';

class BaiseProvider with ChangeNotifier {
  final Api api = Api();
  bool loading = false;
  bool isFailed = false;

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  setFailed(bool status) {
    Timer(const Duration(milliseconds: 50), () {
      isFailed = status;
      notifyListeners();
    });
  }
}