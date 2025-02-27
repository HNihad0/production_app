import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/remote/product_detail_response.dart';
import '../../data/model/remote/product_response.dart';
import '../../data/services/product_detail_service.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ProductDetailService productDetailService;
  final Map<ProductDetailResponse, double> selectedProducts = {};

  final TextEditingController sayController = TextEditingController();
  final TextEditingController cekiController = TextEditingController();

  ProductDetailCubit({required this.productDetailService})
      : super(ProductDetailInitial());

  Future<void> fetchProductDetailsById(ProductResponse product) async {
    try {
      emit(ProductDetailLoading());

      final List<ProductDetailResponse> productDetails =
          await productDetailService.fetchProductsDetail();

      final filteredProducts =
          productDetails.where((detail) => detail.mal == product.idn).toList();

      if (filteredProducts.isEmpty) {
        emit(ProductDetailError(message: 'Məhsul inqrediyenti yoxdur'));
      } else {
        emit(ProductDetailSuccess(
            productDetails: filteredProducts, selectedProducts: {}));
      }
    } catch (e) {
      emit(ProductDetailError(message: e.toString()));
    }
  }

  void selectProduct(ProductDetailResponse product) {
    selectedProducts.update(product, (count) => count + 1.0,
        ifAbsent: () => 1.0);
    emit(ProductDetailSuccess(
        productDetails: (state as ProductDetailSuccess).productDetails,
        selectedProducts: Map.from(selectedProducts)));
  }

  void incrementProduct(ProductDetailResponse product) {
    selectedProducts.update(product, (count) => count + 1.0,
        ifAbsent: () => 1.0);
    emit(ProductDetailSuccess(
        productDetails: (state as ProductDetailSuccess).productDetails,
        selectedProducts: Map.from(selectedProducts)));
  }

  void decrementProduct(ProductDetailResponse product) {
    if (selectedProducts.containsKey(product) &&
        selectedProducts[product]! > 1) {
      selectedProducts.update(
          product, (count) => (count - 1.0).clamp(0.0, double.infinity));
      emit(ProductDetailSuccess(
          productDetails: (state as ProductDetailSuccess).productDetails,
          selectedProducts: Map.from(selectedProducts)));
    }
  }

  void removeProduct(ProductDetailResponse product) {
    selectedProducts.remove(product);
    emit(ProductDetailSuccess(
        productDetails: (state as ProductDetailSuccess).productDetails,
        selectedProducts: Map.from(selectedProducts)));
  }

  void updateProductQuantity(
      ProductDetailResponse product, double newQuantity) {
    if (newQuantity > 0) {
      selectedProducts[product] = newQuantity;
      emit(ProductDetailSuccess(
          productDetails: (state as ProductDetailSuccess).productDetails,
          selectedProducts: Map.from(selectedProducts)));
    }
  }

  void clearControllers() {
    sayController.clear();
    cekiController.clear();
  }
}
