import 'package:flutter/material.dart';
import 'package:iti_final_project/feature/auth/login/view.dart';
import 'package:lottie/lottie.dart';

import '../../core/resources/app_assets.dart';
import '../../core/resources/cache_helper.dart';
import '../homenav/navigation_botton.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState(){
    Future.delayed(
        Duration(seconds: 4),()async{
      CacheHelper.getToken().then((value){
        if(value.isNotEmpty){
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) {
                    return HomeNav();
                  }));

        }else{
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context){
                    return Login();
                  }));
        }
      });
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffC6C6C8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(AppAssets.splash)
            ],
          ),
        ),
      ),
    );
  }
}
