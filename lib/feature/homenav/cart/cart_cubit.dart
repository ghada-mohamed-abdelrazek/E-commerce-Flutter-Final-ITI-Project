import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_project/feature/model/cart_model.dart';

import 'cart_item.dart';

class CartCubit extends Cubit<Map<int, CartItem>> {
  CartCubit() : super({});

  void addToCart(CartProduct product) {
    if (product.id < 0) return; // أو throw

    final cart = Map<int, CartItem>.from(state);

    if (cart.containsKey(product.id)) {
      cart[product.id]!.quantity += 1;
    } else {
      cart[product.id] = CartItem(product: product, quantity: 1);
    }

    emit(cart);
  }

  void increase(int productId) {
    final cart = Map<int, CartItem>.from(state);
    if (cart.containsKey(productId)) {
      cart[productId]!.quantity += 1;
      emit(cart);
    }
  }

  void decrease(int productId) {
    final cart = Map<int, CartItem>.from(state);
    if (cart.containsKey(productId)) {
      if (cart[productId]!.quantity > 1) {
        cart[productId]!.quantity -= 1;
      } else {
        cart.remove(productId);
      }
      emit(cart);
    }
  }
  void clearCart() {
    emit({});
  }
  void removeFromCart(int productId) {
    final cart = Map<int, CartItem>.from(state);
    cart.remove(productId);
    emit(cart);
  }

  double get subtotalPrice =>
      state.values.fold(0, (sum, item) => sum + item.product.price * item.quantity);

  double get totalPrice {
    const shipping = 80.0;
    return subtotalPrice + (state.isEmpty ? 0 : shipping);
  }
}
