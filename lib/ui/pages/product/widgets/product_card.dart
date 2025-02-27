import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/productDetail/product_detail_cubit.dart';
import '../../../../data/model/remote/product_response.dart';
import '../../../../data/services/product_detail_service.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_paddings.dart';
import '../../../../utils/constants/app_radiuses.dart';
import '../../product_detail/product_detail_page.dart';

class ProductCard extends StatelessWidget {
  final ProductResponse product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cardColor = product.category == "Hazır fabrikat"
        ? AppColors.tileColor
        : AppColors.aquamarine;
    final textColor = product.category == "Hazır fabrikat"
        ? AppColors.blue
        : AppColors.bisque;

    return GestureDetector(
      onTap: () {
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => ProductDetailCubit(
                productDetailService: ProductDetailService(),
              )..fetchProductDetailsById(product.idn), 
              child: ProductDetailPage(productId: product.idn),
            ),
          ),
        );
      },
      child: Card(
        color: cardColor,
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
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
