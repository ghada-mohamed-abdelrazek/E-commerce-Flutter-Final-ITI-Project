import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_project/core/resources/app_assets.dart';
import 'package:iti_final_project/feature/homenav/cart/cart_cubit.dart';
import 'package:lottie/lottie.dart';

void appPlaceOrder(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                AppAssets.placeOrder,
                repeat: false,
                onLoaded: (composition) async {
                  await Future.delayed(composition.duration);

                  context.read<CartCubit>().clearCart();

                  Navigator.pop(context); // close dialog
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
