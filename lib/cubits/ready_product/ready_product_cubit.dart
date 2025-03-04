import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/remote/ready_product_response.dart';
import '../../data/services/product_service.dart';

part 'ready_product_state.dart';

class ReadyProductCubit extends Cubit<ReadyProductState> {
  final ProductService productService;

  ReadyProductCubit({required this.productService})
      : super(ReadyProductInitial());

  Future<void> fetchReadyProducts() async {
    try {
      log('Fetching products...');
      emit(ReadyProductLoading());

      final List<ReadyProductResponse> readyProducts =
          await productService.fetchReadyProduct();

      log('Products fetched: ${readyProducts.length}');

      if (readyProducts.isEmpty) {
        log('No ready products found');
        emit(ReadyProductError(message: 'Hazırlanan məhsul yoxdur'));
      } else {
        log('Ready products found: ${readyProducts.length}');
        emit(ReadyProductSuccess(readyProduct: readyProducts));
      }
    } catch (e) {
      log('Error fetching products: $e');
      emit(ReadyProductNetworkError(message: e.toString()));
    }
  }

  Future<void> updateProductStatus(String senNo, int stat) async {
    try {
      log('Updating product status for senNo: $senNo to $stat');
      emit(ReadyProductLoading());

      await productService.updateProductStatus(senNo, stat);

      log('Product status updated successfully');

      final List<ReadyProductResponse> updatedProducts =
          await productService.fetchReadyProduct();

      emit(ReadyProductSuccess(readyProduct: updatedProducts));
    } catch (e) {
      log('Error updating product status: $e');
      emit(ReadyProductError(message: 'Status yenilənmədi: $e'));
    }
  }

  Future<void> deleteProduct(String senNo) async {
    try {
      log('Deleting product senNo: $senNo');
      emit(ReadyProductLoading());

      await productService.deleteProduct(senNo);

      log('Product deleted');

      final List<ReadyProductResponse> updatedProducts =
          await productService.fetchReadyProduct();

      emit(ReadyProductSuccess(readyProduct: updatedProducts));
    } catch (e) {
      log('Error deleting product: $e');
      emit(ReadyProductError(message: 'Məhsul silinmədi: $e'));
    }
  }
}
