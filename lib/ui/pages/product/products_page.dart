import 'package:flutter/material.dart';

import '../../widgets/custom_app_bar.dart';
import 'finished_product_page.dart';
import 'semi_products_page.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "Yarım fabrikat"),
              Tab(text: "Hazır məhsul"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SemiProductsPage(),
            FinishedProductsPage(),
          ],
        ),
      ),
    );
  }
}
