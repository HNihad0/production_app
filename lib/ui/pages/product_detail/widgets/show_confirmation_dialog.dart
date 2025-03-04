import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/productDetail/product_detail_cubit.dart';
import '../../../../data/model/remote/product_response.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/extensions/num_extensions.dart';
import '../../../../utils/helpers/go.dart';
import '../../../../utils/helpers/pager.dart';

Future<void> showConfirmationDialog(
    BuildContext context, ProductResponse product) {
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
              context.read<ProductDetailCubit>().postSelectedProducts();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Məhsul uğurla təsdiqləndi!'),
                  backgroundColor: AppColors.green,
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );

              Future.delayed(const Duration(seconds: 2), () {
                Go.replace(context, Pager.home);
              });
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
