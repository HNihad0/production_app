import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/productDetail/product_detail_cubit.dart';
import '../../../../utils/constants/app_paddings.dart';
import '../../../../utils/constants/app_radiuses.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProductDetailError) {
          return Center(child: Text(state.message));
        }
        if (state is ProductDetailSuccess) {
          final productDetails = state.productDetails;
          return GridView.builder(
            padding: AppPaddings.a16,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 1.5,
            ),
            itemCount: productDetails.length,
            itemBuilder: (context, index) {
              final product = productDetails[index];
              return GestureDetector(
                onTap: () {
                  context.read<ProductDetailCubit>().selectProduct(product);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadiuses.a12,
                  ),
                  elevation: 4.0,
                  child: Padding(
                    padding: AppPaddings.a16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: Text('Məhsul inqrediyenti yoxdur'));
      },
    );
  }
}
