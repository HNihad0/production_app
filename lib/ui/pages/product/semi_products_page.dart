import 'package:amoris_new/ui/widgets/custom_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/product/product_cubit.dart';
import 'widgets/product_grid.dart';

class SemiProductsPage extends StatelessWidget {
  const SemiProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (_, state) {
        if (state is ProductLoading) {
          return const Center(child: CustomProgressLoading.medium());
        }
        if (state is ProductError) {
          return Center(child: Text('Xəta: ${state.message}'));
        }
        if (state is ProductNetworkError) {
          return Center(child: Text('İnternet xətası: ${state.message}'));
        }
        if (state is ProductSuccess) {
          final filteredProducts = state.products.where((p) => p.category == "").toList();
          return ProductGrid(products: filteredProducts);
        }
        return const Center(child: Text('Məhsul yoxdur'));
      },
    );
  }
}
