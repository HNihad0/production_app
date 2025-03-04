part of 'ready_product_cubit.dart';

@immutable
sealed class ReadyProductState {}

final class ReadyProductInitial extends ReadyProductState {}

final class ReadyProductLoading extends ReadyProductState {}

final class ReadyProductSuccess extends ReadyProductState {
  final List<ReadyProductResponse> readyProduct;

  ReadyProductSuccess({required this.readyProduct});
}

final class ReadyProductError extends ReadyProductState {
   final String message;

  ReadyProductError({required this.message});
}

final class ReadyProductNetworkError extends ReadyProductState {
  final String message;

  ReadyProductNetworkError({required this.message});
}
