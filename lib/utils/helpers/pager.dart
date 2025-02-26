import 'package:amoris_new/ui/pages/home/home_page.dart';
import 'package:amoris_new/ui/pages/product/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/product/product_cubit.dart';
import '../../data/services/product_service.dart';
import '../../ui/pages/splash/splash_page.dart';

class Pager {
  Pager._();

  static Widget get splash => const SplashPage();
  static Widget get home => const HomePage();
  static Widget get products {
    return BlocProvider(
      create: (context) =>
          ProductCubit(productService: ProductService())..fetchProducts(),
      child: const ProductsPage(),
    );
  }
}
