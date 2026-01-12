import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_project/core/resources/app_color.dart';
import 'package:iti_final_project/core/resources/app_place_order.dart';

import 'cart_cubit.dart';
import 'cart_item.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, Map<int, CartItem>>(
      builder: (context, cartItems) {
        final cartCubit = context.read<CartCubit>();
        final totalPrice = cartCubit.totalPrice;
        final subtotalPrice = cartCubit.subtotalPrice;
        if (cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_bag_outlined, size: 150,
                    color: Colors.grey)
              ],
            ),
          );
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: SizedBox.shrink(),
            title: Text("My Cart",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 200,
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Sub-total",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.primaryGray,
                      ),
                    ),
                    Spacer(),
                    Text('\$${subtotalPrice.toString()}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1A1A1A),
                      ),)
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text("VAT (%)",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.primaryGray,
                      ),
                    ),
                    Spacer(),
                    Text(r"$ 0.00",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1A1A1A),
                      ),)
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text("Shipping fee",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.primaryGray,
                      ),
                    ),
                    Spacer(),
                    Text(r"$ 80",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1A1A1A),
                      ),)
                  ],
                ),
                SizedBox(height: 8),
                Divider(),
                Row(
                  children: [
                    Text("Total ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.primaryGray,
                      ),
                    ),
                    Spacer(),
                    Text('\$ ${totalPrice.toString()} ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1A1A1A),
                      ),)
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    appPlaceOrder(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      fixedSize: Size(350, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                      )

                  ),
                  child: Text("Go To Checkout",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final cartEntry = cartItems.entries.toList()[index];
                          final product = cartEntry.value.product;
                          final quantity = cartEntry.value.quantity;
                          final productId = cartEntry.key;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    width: 1, color: Color(0xffE6E6E6),
                                  )
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Image.network(product.image ?? '',
                                          width: 80,
                                          height: 79,
                                          errorBuilder: (context, error,
                                              stackType) {
                                            return Container(
                                              color: Colors.grey[300],
                                              child: Icon(Icons.image),
                                            );
                                          },
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            title: Text(product.title ?? '',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14
                                                ),
                                                maxLines: 2
                                            ),
                                            trailing: GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<CartCubit>()
                                                      .removeFromCart(
                                                      productId);
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Color(0xffED1010),)),
                                            subtitle: Text('\$${product.price
                                                ?.toString() ?? ''}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14
                                              ),),
                                            leading: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,

                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<CartCubit>()
                                                        .decrease(productId);
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor: Color(
                                                        0xffFFFFFF),
                                                    child: Icon(Icons.remove,
                                                      color: Color(
                                                          0xff6D3805),
                                                      size: 16,),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12),
                                                  child: Text("$quantity",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight
                                                              .w400,
                                                          color: Color(
                                                              0xff804F1E)
                                                      )),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<CartCubit>()
                                                        .increase(productId);
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor: Color(
                                                        0xffFFFFFF),
                                                    child: Icon(Icons.add,
                                                      color: Color(
                                                          0xff6D3805),
                                                      size: 16,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          );
                        }
                    )
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
