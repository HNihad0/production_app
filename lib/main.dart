import 'package:amoris_new/cubits/ready_product/ready_product_cubit.dart';
import 'package:amoris_new/data/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/app.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
            ReadyProductCubit(productService: ProductService()),
      ),
    ],
    child: const MyApp(),
  ));
}
