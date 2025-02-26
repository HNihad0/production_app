import 'package:amoris_new/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_durations.dart';
import '../../../utils/helpers/go.dart';
import '../../../utils/helpers/pager.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(AppDurations.s3, 
    () {
      Go.replace(context, Pager.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Image.asset(
          AppAssets.logo, 
          height: 225,
          width: 225,
        ),
      ),
    );
  }
}
