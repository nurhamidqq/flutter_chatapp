import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void showSnackBar(String message) => ScaffoldMessenger.of(this)
    ..clearSnackBars()
    ..showSnackBar(SnackBar(content: Text(message)));
}
