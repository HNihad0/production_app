import 'package:amoris_new/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

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
            Center(child: Text("Yarım fabrikat")),
            Center(child: Text("Hazır məhsul")),
          ],
        ),
      ),
    );
  }
}
