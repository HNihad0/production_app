import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/ready_product/ready_product_cubit.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_durations.dart';
import '../../../../utils/extensions/num_extensions.dart';

class ProductDialog extends StatelessWidget {
  final String senNo;
  final Map<String, List<Map<String, String>>> elMalAdiGroups;
  final dynamic stat;

  const ProductDialog({
    super.key,
    required this.senNo,
    required this.elMalAdiGroups,
    required this.stat,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('№$senNo'),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          )
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: elMalAdiGroups.entries.map((entry) {
            final elMalAdi = entry.key;
            final silMalAdiList = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  elMalAdi,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ...silMalAdiList.map(
                  (item) => Text(
                    "${item['silMalAdi']} - ${item['silMiqdar']}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                10.h,
              ],
            );
          }).toList(),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (stat == true)
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Bağla',
                  style: TextStyle(
                    color: AppColors.cinnabar,
                  ),
                ),
              )
            else
              TextButton(
                 onPressed: () => _showDeleteConfirmationDialog(context),
                child: const Text(
                  'Məhsulu sil',
                  style: TextStyle(
                    color: AppColors.cinnabar,
                  ),
                ),
              ),
            if (stat != true)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                ),
                onPressed: () {
                  final cubit = context.read<ReadyProductCubit>();
                  cubit.updateProductStatus(senNo, 1);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Məhsul statusu uğurla yeniləndi'),
                      backgroundColor: AppColors.accessGreen,
                      duration: AppDurations.s2,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );

                  Navigator.pop(context);
                },
                child: Text(
                  "Təsdiqlə",
                  style: TextStyle(color: AppColors.white),
                ),
              ),
          ],
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Məhsul silinsin?'),
          content: const Text('Bu əməliyyat geri alınmaz. Əminsiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İmtina'),
            ),
            TextButton(
              onPressed: () {
                final cubit = context.read<ReadyProductCubit>();
                cubit.deleteProduct(senNo); 

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Məhsul uğurla silindi'),
                    backgroundColor: AppColors.accessGreen,
                    duration: AppDurations.s2,
                    behavior: SnackBarBehavior.floating,
                  ),
                );

                Navigator.pop(context); // Close the confirmation dialog
                Navigator.pop(context); // Close the product dialog
              },
              child: const Text(
                'Sil',
                style: TextStyle(color: AppColors.cinnabar),
              ),
            ),
          ],
        );
      },
    );
  }
}
