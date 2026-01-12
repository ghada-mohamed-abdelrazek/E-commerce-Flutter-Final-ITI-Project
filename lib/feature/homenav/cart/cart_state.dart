part of 'cart_cubit.dart';

abstract class CartState {}

class CartStateInitial extends CartState {}
class CartStateLoading extends CartState {}
class CartStateSuccess extends CartState {}
class CartStateFailure extends CartState {
  final String errMsg;
  CartStateFailure(this.errMsg);
}
