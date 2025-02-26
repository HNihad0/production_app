import 'package:flutter/material.dart';

import 'app_radiuses.dart';

class AppBorders {
  AppBorders._();

  static OutlineInputBorder get inputBorder => const OutlineInputBorder(
        borderRadius: AppRadiuses.a16,
        borderSide: BorderSide(color: Colors.black),
      );

  static const noBorder = InputBorder.none;
}
