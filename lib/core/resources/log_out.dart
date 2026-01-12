import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iti_final_project/core/resources/app_images.dart';

import '../../feature/auth/login/view.dart';
import 'cache_helper.dart';

class LogOutSheet {

  static void show(BuildContext context){
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              height: 350,
              width: 350,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 12,
                  children: [
                    SvgPicture.asset(AppImages.warning),
                    Text("Sign Out?",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff1A1A1A)
                      ),
                    ),
                    Text("Are you sure you want to Sign Out?",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff808080)
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        CacheHelper.deleteToken();
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Login()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFED1010),
                          fixedSize: Size(293, 54),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          )

                      ),
                      child: Text("Yes, Sign Out",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: Size(293, 54),
                          side:BorderSide(color: Color(0xFFCCCCCC)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),

                          )

                      ),
                      child: Text("No, Cancel",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}