import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';
import '../utils/helpers/pager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soffen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainBlue),
        useMaterial3: true,
      ),
      home: Pager.splash,
      debugShowCheckedModeBanner: false,
    );
  }
}
