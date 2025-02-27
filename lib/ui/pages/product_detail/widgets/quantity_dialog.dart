import 'package:flutter/material.dart';

Future<double?> showQuantityDialog(BuildContext context, double currentQuantity) async {
  TextEditingController controller = TextEditingController(text: currentQuantity.toStringAsFixed(1));

  return showDialog<double>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Miqdarı dəyiş"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: "Yeni miqdarı daxil edin",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Ləğv et"),
          ),
          TextButton(
            onPressed: () {
              final double? newQuantity = double.tryParse(controller.text);
              if (newQuantity != null && newQuantity > 0) {
                Navigator.pop(context, newQuantity);
              }
            },
            child: const Text("Təsdiqlə"),
          ),
        ],
      );
    },
  );
}
