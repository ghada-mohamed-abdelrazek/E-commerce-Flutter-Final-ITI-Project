import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'app_assets.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Lottie.asset(AppAssets.loading,
          width: 400,
            height: 100
          ),

          ),
        ],
      ),
    );
  }
}