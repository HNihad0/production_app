import 'package:flutter/material.dart';

import '../../../data/model/remote/product_response.dart';
import '../../../utils/constants/app_paddings.dart';
import '../../widgets/custom_app_bar.dart';
import 'widgets/product_grid.dart';
import 'widgets/select_products_list.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductResponse product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: AppPaddings.a12,
              child: SelectedProductsListView(product: product),
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
