import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/productDetail/product_detail_cubit.dart';
import '../../../../utils/constants/app_colors.dart';

class SelectedProductsListView extends StatelessWidget {
  const SelectedProductsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailSuccess &&
            state.selectedProducts.isNotEmpty) {
          return ListView.builder(
            itemCount: state.selectedProducts.length,
            itemBuilder: (context, index) {
              final product = state.selectedProducts.keys.elementAt(index);
              final count = state.selectedProducts[product]!;

              return Dismissible(
                key: Key(product.malAdi),
                direction: DismissDirection.horizontal,
                onDismissed: (direction) {
                  context.read<ProductDetailCubit>().removeProduct(product);
                },
                background: Container(
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: Card(
                  color: AppColors.lightGreen,
                  child: ListTile(
                    title: Text(
                      product.malAdi,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            context
                                .read<ProductDetailCubit>()
                                .decrementProduct(product);
                          },
                        ),
                        Text(
                          count.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            context
                                .read<ProductDetailCubit>()
                                .incrementProduct(product);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: Text('Seçilmiş məhsul yoxdur'));
      },
    );
  }
}
