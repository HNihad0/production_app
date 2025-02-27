part of 'product_detail_cubit.dart';

@immutable
sealed class ProductDetailState {}

final class ProductDetailInitial extends ProductDetailState {}

final class ProductDetailLoading extends ProductDetailState {}

final class ProductDetailSuccess extends ProductDetailState {
  final List<ProductDetailResponse> productDetails;
  final Map<ProductDetailResponse, double> selectedProducts;

  ProductDetailSuccess({required this.selectedProducts,required this.productDetails});
}

final class ProductDetailError extends ProductDetailState {
     final String message;

  ProductDetailError({required this.message});
}

final class ProductDetailNetworkError extends ProductDetailState {}

