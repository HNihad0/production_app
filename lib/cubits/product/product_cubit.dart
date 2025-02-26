import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/remote/product_response.dart';
import '../../data/services/product_service.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductService productService;

  ProductCubit({required this.productService}) : super(ProductInitial());

  Future<void> fetchProducts() async {
    try {
      emit(ProductLoading());

      final List<ProductResponse> products =
          await productService.fetchProducts();

      if (products.isEmpty) {
        emit(ProductError(message: 'Məhsul yoxdur'));
      } else {
        emit(ProductSuccess(products: products));
      }
    } catch (e) {
      emit(ProductNetworkError(message: e.toString()));
    }
  }
}
