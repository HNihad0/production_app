import 'package:amoris_new/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/productDetail/product_detail_cubit.dart';

Future<void> showConfirmationDialog(BuildContext context) {
  final productCubit = context.read<ProductDetailCubit>();

  productCubit.clearControllers();

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Məhsul məlumatları"),
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
