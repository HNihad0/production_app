import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/productDetail/product_detail_cubit.dart';
import '../../../../data/model/remote/product_response.dart';
import '../../../../utils/constants/app_colors.dart';

Future<void> showConfirmationDialog(BuildContext context,ProductResponse product) {
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
            const SizedBox(height: 10),
            TextField(
              controller: productCubit.cekiController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Çəki"),
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
              final say = productCubit.sayController.text.trim();
              final ceki = productCubit.cekiController.text.trim();
              if (say.isNotEmpty && ceki.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text("Məhsul təsdiqləndi: Say = $say, Çəki = $ceki"),
                  ),
                );
                Navigator.pop(context);
              }
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
