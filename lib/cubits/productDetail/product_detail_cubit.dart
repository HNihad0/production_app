import 'dart:developer';

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
  final TextEditingController neferController = TextEditingController();

  ProductResponse? selectedProduct;

  ProductDetailCubit({required this.productDetailService})
      : super(ProductDetailInitial());

  Future<void> fetchProductDetailsById(ProductResponse product) async {
    try {
      log("Fetching product details for: ${product.adi}");

      emit(ProductDetailLoading());

      final List<ProductDetailResponse> productDetails =
          await productDetailService.fetchProductsDetail();

      final filteredProducts =
          productDetails.where((detail) => detail.idn == product.idn).toList();

      selectedProduct = product;
      log("Selected Product: ${product.adi}");
      log("Selected Product Code: ${product.kod}");
      log("Selected Product ID: ${product.idn}");

      if (filteredProducts.isEmpty) {
        log("No ingredients found for: ${product.adi}");
        emit(ProductDetailError(message: 'Məhsul inqrediyenti yoxdur'));
      } else {
        log("Product details fetched successfully");
        emit(ProductDetailSuccess(
          productDetails: filteredProducts,
          selectedProducts: {},
          selectedProduct: product,
        ));
      }
    } catch (e) {
      log("Error fetching product details: $e");
      emit(ProductDetailError(message: e.toString()));
    }
  }

  void selectProduct(ProductDetailResponse product) {
    log("Selecting product: ${product.name}");
    log("Selecting product ID: ${product.mal}");
    selectedProducts.update(product, (count) => count + 1.0,
        ifAbsent: () => 1.0);
    _emitUpdatedState();
  }

  void incrementProduct(ProductDetailResponse product) {
    log("Incrementing quantity for: ${product.name}");
    selectedProducts.update(product, (count) => count + 1.0,
        ifAbsent: () => 1.0);
    _emitUpdatedState();
  }

  void decrementProduct(ProductDetailResponse product) {
    if (selectedProducts.containsKey(product) &&
        selectedProducts[product]! > 1) {
      log("Decrementing quantity for: ${product.name}");
      selectedProducts.update(
          product, (count) => (count - 1.0).clamp(0.0, double.infinity));
      _emitUpdatedState();
    } else {
      log("Cannot decrement: ${product.name} - Minimum quantity reached");
    }
  }

  void removeProduct(ProductDetailResponse product) {
    log("Removing product: ${product.name}");
    selectedProducts.remove(product);
    _emitUpdatedState();
  }

  void updateProductQuantity(
      ProductDetailResponse product, double newQuantity) {
    if (newQuantity > 0) {
      log("Updating quantity for: ${product.name} to $newQuantity");
      selectedProducts[product] = newQuantity;
      _emitUpdatedState();
    } else {
      log("Invalid quantity: $newQuantity for ${product.name}");
    }
  }

  void clearControllers() {
    log("Clearing text controllers");
    sayController.clear();
    cekiController.clear();
  }

  Future<void> postSelectedProducts() async {
    if (selectedProduct == null) {
      log("Error: No product selected for posting.");
      return;
    }

    try {
      log("Posting selected product...");

      List<Map<String, dynamic>> productList =
          selectedProducts.entries.map((entry) {
        final product = entry.key;
        final productCount = entry.value;

        return {
          "productCode": product.mal.toString(),
          "productWare": product.mal,
          "productCount": productCount,
        };
      }).toList();

      bool success = await productDetailService.postProductDetail(
        code: selectedProduct!.kod,
        ware: selectedProduct!.idn,
        count: sayController.text.isEmpty
            ? 0.0
            : double.tryParse(sayController.text) ?? 0.0,
        weight: cekiController.text.isEmpty
            ? 0.0
            : double.tryParse(cekiController.text) ?? 0.0,
        selectedProducts: productList,
      );

      if (success) {
        log("Successfully posted: ${selectedProduct!.adi}");
      } else {
        log("Failed to post: ${selectedProduct!.adi}");
      }
    } catch (e) {
      log("Error posting selected product: $e");
    }
  }

  void _emitUpdatedState() {
    log("Emitting updated state with selected products:");
    selectedProducts.forEach((key, value) {
      log("- ${key.name}: $value");
    });
    emit(ProductDetailSuccess(
      productDetails: (state as ProductDetailSuccess).productDetails,
      selectedProducts: Map.from(selectedProducts),
      selectedProduct: selectedProduct!,
    ));
  }
}
