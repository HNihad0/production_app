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
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProductError) {
          return Center(child: Text('Hata: ${state.message}'));
        }

        if (state is ProductNetworkError) {
          return Center(child: Text('Ağ Hatası: ${state.message}'));
        }

        if (state is ProductSuccess) {
          final products = state.products;
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.8,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadiuses.a12,
                ),
                elevation: 4.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.adi,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: AppPaddings.a8,
                      child:
                          Text('Kategori: ${product.category ?? "Bilinmiyor"}'),
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
