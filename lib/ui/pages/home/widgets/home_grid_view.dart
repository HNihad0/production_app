import 'package:flutter/material.dart';

import '../../../../data/model/remote/ready_product_response.dart';
import '../../../../utils/constants/app_paddings.dart';
import 'home_grid_card.dart';
import 'product_dialog.dart';

class HomeGridView extends StatelessWidget {
  final List readyProducts;

  const HomeGridView({super.key, required this.readyProducts});

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, List<Map<String, String>>>> groupedBySenNo = {};

    for (var product in readyProducts) {
      final elMalAdi = product.elMalAdi;
      final senNo = product.senNo;
      final silMalAdi = product.silMalAdi;
      final silMiqdar = product.silMiqdar?.toString() ?? '';

      if (elMalAdi != null && senNo != null && silMalAdi != null) {
        groupedBySenNo.putIfAbsent(senNo, () => {});
        groupedBySenNo[senNo]!.putIfAbsent(elMalAdi, () => []);
        groupedBySenNo[senNo]![elMalAdi]!
            .add({'silMalAdi': silMalAdi, 'silMiqdar': silMiqdar});
      }
    }

    return Padding(
      padding: AppPaddings.a16,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: groupedBySenNo.length,
        itemBuilder: (context, index) {
          final senNo = groupedBySenNo.keys.elementAt(index);
          final elMalAdiGroups = groupedBySenNo[senNo]!;
          final product = readyProducts.firstWhere((p) => p.senNo == senNo,
              orElse: () => ReadyProductResponse(senNo: senNo));
          final stat = product.stat ?? false;

          return HomeGridCard(
            senNo: senNo,
            elMalAdiGroups: elMalAdiGroups,
            stat: stat,
            onTap: () =>
                _showProductDialog(context, senNo, elMalAdiGroups, stat),
          );
        },
      ),
    );
  }

  void _showProductDialog(BuildContext context, String senNo,
      Map<String, List<Map<String, String>>> elMalAdiGroups, dynamic stat) {
    showDialog(
      context: context,
      builder: (context) {
        return ProductDialog(
          senNo: senNo,
          elMalAdiGroups: elMalAdiGroups,
          stat: stat,
        );
      },
    );
  }
}
