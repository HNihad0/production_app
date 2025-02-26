import 'package:amoris_new/utils/constants/app_assets.dart';
import 'package:amoris_new/utils/extensions/num_extensions.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final TabBar? bottom; 

  const CustomAppBar({
    super.key,
    this.title = "Soffen",
    this.actions,
    this.bottom, 
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.logo,
            width: 50,
            height: 50,
          ),
          8.w,
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: actions,
      bottom: bottom, 
    );
  }

  @override
  Size get preferredSize => bottom == null
      ? const Size.fromHeight(kToolbarHeight) 
      : Size.fromHeight(kToolbarHeight + 75);
}
