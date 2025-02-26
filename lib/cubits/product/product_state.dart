part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {
  final List<ProductResponse> products;

  ProductSuccess({required this.products});
}

final class ProductError extends ProductState {
   final String message;

  ProductError({required this.message});
}

final class ProductNetworkError extends ProductState {
    final String message;

  ProductNetworkError({required this.message});
}

