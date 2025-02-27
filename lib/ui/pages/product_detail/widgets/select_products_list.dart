import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/productDetail/product_detail_cubit.dart';
import '../../../../data/model/remote/product_response.dart';
import '../../../../utils/constants/app_colors.dart';
import 'quantity_dialog.dart';
import 'show_confirmation_dialog.dart';

class SelectedProductsListView extends StatelessWidget {
  final ProductResponse product;
  const SelectedProductsListView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      builder: (_, state) {
        if (state is ProductDetailSuccess) {
          final hasSelectedProducts = state.selectedProducts.isNotEmpty;
          return Column(
            children: [
              Text(
                product.adi,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.selectedProducts.length,
                  itemBuilder: (context, index) {
                    final product =
                        state.selectedProducts.keys.elementAt(index);
                    final count = state.selectedProducts[product]!;

                    return Dismissible(
                      key: Key(product.malAdi),
                      direction: DismissDirection.horizontal,
                      onDismissed: (direction) {
                        context
                            .read<ProductDetailCubit>()
                            .removeProduct(product);
                      },
                      background: Container(
                        color: AppColors.cinnabar,
                        child: const Icon(Icons.delete, color: AppColors.white),
                      ),
                      secondaryBackground: Container(
                        color: AppColors.cinnabar,
                        child: const Icon(Icons.delete, color: AppColors.white),
                      ),
                      child: Card(
                        color: AppColors.lightGreen,
                        child: ListTile(
                          title: Text(
                            product.malAdi,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  context
                                      .read<ProductDetailCubit>()
                                      .decrementProduct(product);
                                },
                              ),
                              GestureDetector(
                                onDoubleTap: () async {
                                  final newQuantity =
                                      await showQuantityDialog(context, count);
                                  if (newQuantity != null) {
                                    context
                                        .read<ProductDetailCubit>()
                                        .updateProductQuantity(
                                            product, newQuantity);
                                  }
                                },
                                child: Text(
                                  count.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
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
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cinnabar,
                        minimumSize: Size(125, 55),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Ləğv et",
                        style: TextStyle(
                          color: AppColors.bisque,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accessGreen,
                        minimumSize: Size(125, 55),
                      ),
                      onPressed: hasSelectedProducts
                          ? () => showConfirmationDialog(context)
                          : null,
                      child: const Text(
                        "Təsdiqlə",
                        style: TextStyle(
                          color: AppColors.bisque,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return const Center(child: Text('Seçilmiş məhsul yoxdur'));
      },
    );
  }
}
