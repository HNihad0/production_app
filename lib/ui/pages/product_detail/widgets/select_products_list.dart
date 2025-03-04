import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/productDetail/product_detail_cubit.dart';
import '../../../../data/model/remote/product_response.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/extensions/num_extensions.dart';
import '../../../../utils/helpers/go.dart';
import '../../../../utils/helpers/pager.dart';
import 'quantity_dialog.dart';

class SelectedProductsListView extends StatelessWidget {
  final ProductResponse product;
  const SelectedProductsListView({super.key, required this.product});

  Future<void> showConfirmationDialog(BuildContext context) {
    final productCubit = context.read<ProductDetailCubit>();

    productCubit.clearControllers();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("${product.adi} - ${product.kod}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: productCubit.sayController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Say"),
              ),
              10.h,
              TextField(
                controller: productCubit.cekiController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Çəki"),
              ),
              10.h,
              TextField(
                controller: productCubit.neferController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Nəfər"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Ləğv et",
                style: TextStyle(
                  color: AppColors.cinnabar,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
              ),
              onPressed: () {
                productCubit.postSelectedProducts();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Məhsul uğurla təsdiqləndi!'),
                    backgroundColor: AppColors.green,
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );

                Go.replace(context, Pager.home);
              },
              child: const Text(
                "Təsdiqlə",
                style: TextStyle(
                  color: AppColors.lightGreen,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

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
                      key: Key(product.name),
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
                            product.name,
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
