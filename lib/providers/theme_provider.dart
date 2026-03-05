// import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeProvider extends Notifier<bool> {
  void toggleBrightness(bool value) {
    state = !value;
  }

  @override
  bool build() {
    // TODO: implement build
    return false;
  }
}

var themeProvider = NotifierProvider<ThemeProvider, bool>(
  ThemeProvider.new,
);
