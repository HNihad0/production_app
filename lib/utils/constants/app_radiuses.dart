import 'package:flutter/material.dart';

class AppRadiuses {
  AppRadiuses._();
  
  static const a8 = BorderRadius.all(Radius.circular(8));
  static const a12 = BorderRadius.all(Radius.circular(12));
  static const a16 = BorderRadius.all(Radius.circular(16));
  static const a20 = BorderRadius.all(Radius.circular(20));
  static const a30 = BorderRadius.all(Radius.circular(30));


  static const aR16 = RoundedRectangleBorder(borderRadius: AppRadiuses.a16);
}
