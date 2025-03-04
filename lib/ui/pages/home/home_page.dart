import 'package:flutter/material.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_radiuses.dart';
import '../../../utils/constants/app_texts.dart';
import '../../../utils/extensions/num_extensions.dart';
import '../../../utils/helpers/go.dart';
import '../../../utils/helpers/pager.dart';
import '../../widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.aquamarine,
                foregroundColor: AppColors.bisque,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadiuses.a16,
                ),
              ),
              onPressed: () => Go.to(context, Pager.products),
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: AppColors.bisque,
                  ),
                  8.w,
                  Text(AppTexts.newOrder),
                ],
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.timelapse_outlined), text: "Gözləmədə"),
              Tab(icon: Icon(Icons.check), text: "Tamamlanmış"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Pager.waitingPage,
            Pager.readyPage,
          ],
        ),
      ),
    );
  }
}
