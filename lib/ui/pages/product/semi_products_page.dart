import 'package:amoris_new/utils/constants/app_colors.dart';
import 'package:amoris_new/utils/constants/app_paddings.dart';
import 'package:amoris_new/utils/constants/app_radiuses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/product/product_cubit.dart';

class SemiProductsPage extends StatelessWidget {
  const SemiProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (_, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProductError) {
          return Center(child: Text('Xəta: ${state.message}'));
        }
        if (state is ProductNetworkError) {
          return Center(child: Text('İnternet xətası: ${state.message}'));
        }
        if (state is ProductSuccess) {
          final products = state.products;
          return GridView.builder(
            padding: AppPaddings.a16,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 1,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                color: AppColors.aquamarine,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadiuses.a16,
                ),
                elevation: 4.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: AppPaddings.a16,
                      child: Text(
                        product.adi,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.bisque
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }

        return const Center(child: Text('Məhsul yoxdur'));
      },
    );
  }
}
