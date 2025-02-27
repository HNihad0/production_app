import 'package:flutter/material.dart';

import '../../../../data/model/remote/product_response.dart';
import '../../../../utils/constants/app_paddings.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductResponse> products;

  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: AppPaddings.a16,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(product: product);
      },
    );
  }
}
