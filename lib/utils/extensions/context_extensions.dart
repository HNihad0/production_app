import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  EdgeInsets get keyboardPadding => MediaQuery.viewInsetsOf(this);
  double get fullHeight => MediaQuery.sizeOf(this).height;
  double get fullWidth => MediaQuery.sizeOf(this).width;
}
