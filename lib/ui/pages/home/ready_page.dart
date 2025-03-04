import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../cubits/ready_product/ready_product_cubit.dart';
import '../../widgets/custom_circular_progress.dart';
import 'widgets/home_grid_view.dart';

class ReadyPage extends StatelessWidget {
  const ReadyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Scaffold(
      body: BlocBuilder<ReadyProductCubit, ReadyProductState>(
        builder: (_, state) {
          if (state is ReadyProductLoading) {
            return const Center(child: CustomProgressLoading.medium());
          } else if (state is ReadyProductError) {
            return Center(child: Text(state.message));
          } else if (state is ReadyProductSuccess) {
            final readyProducts = state.readyProduct
                .where((product) =>
                    product.stat == true &&
                    product.tarix != null &&
                    DateFormat('yyyy-MM-dd').format(product.tarix!) == today)
                .toList();

            if (readyProducts.isEmpty) {
              return const Center(
                  child: Text(
                'Hal hazırda hazırlanmış məhsul yoxdur',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ));
            }

            return HomeGridView(readyProducts: readyProducts);
          } else {
            return const Center(
                child: Text(
              'Məlumat yoxdur',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ));
          }
        },
      ),
    );
  }
}
