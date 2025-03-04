import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/product/product_cubit.dart';
import '../../cubits/ready_product/ready_product_cubit.dart';
import '../../data/services/product_service.dart';
import '../../ui/pages/home/home_page.dart';
import '../../ui/pages/home/ready_page.dart';
import '../../ui/pages/home/waiting_page.dart';
import '../../ui/pages/product/products_page.dart';
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

  static Widget get waitingPage => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ReadyProductCubit(productService: ProductService())
                  ..fetchReadyProducts(),
          ),
        ],
        child: const WaitingPage(),
      );

  static Widget get readyPage => BlocProvider(
        create: (_) => ReadyProductCubit(productService: ProductService())
          ..fetchReadyProducts(),
        child: const ReadyPage(),
      );
}
