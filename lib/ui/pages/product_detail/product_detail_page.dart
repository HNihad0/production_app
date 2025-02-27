import 'package:flutter/material.dart';

import '../../../utils/constants/app_paddings.dart';
import '../../widgets/custom_app_bar.dart';
import 'widgets/product_grid.dart';
import 'widgets/select_products_list.dart';

class ProductDetailPage extends StatelessWidget {
  final int productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: AppPaddings.a16,
              child: const SelectedProductsListView(), 
            ),
          ),
           Expanded(
            flex: 3,
            child: const ProductGridView(), 
          ),
        ],
      ),
    );
  }
}
