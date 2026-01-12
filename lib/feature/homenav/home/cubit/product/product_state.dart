part of 'product_cubit.dart';

abstract class ProductState {}

final class ProductInitial extends ProductState {}
final class ProductLoading extends ProductState {}
final class ProductSuccess extends ProductState {
  List<ProductModel> productmodel;
  ProductSuccess(this.productmodel);
}
final class ProductFailure extends ProductState {
  final String errMsg;
  ProductFailure(this.errMsg);
}
