import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_project/core/network/dio_helper.dart';
import 'package:iti_final_project/core/network/fake_dio_helper.dart';

import 'feature/homenav/cart/cart_cubit.dart';
import 'feature/homenav/navigation_botton.dart';
import 'feature/splash/view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelperFake.initDio();
  DioHelper.initDio();
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider<CartCubit>(create: (_) => CartCubit()),
          ],
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home:Splash(),
    );
  }
}



