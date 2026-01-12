
import 'package:flutter/material.dart';

import 'app_color.dart';

class AppField extends StatelessWidget {
  AppField({
    super.key, this.obsureText = false, required this.hintText,required this.endIcon, this.controller,
  });
  final TextEditingController?controller;
  final bool obsureText;
  final String hintText;
  Widget endIcon;
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,

      obscureText: obsureText,
      decoration: InputDecoration(
        filled: true,
        suffixIcon: endIcon ,
        fillColor:AppColor.background,
        border: OutlineInputBorder(
          borderSide: BorderSide(color:AppColor.primaryInputBorderColor, width: 2)
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryInputBorderColor),
            borderRadius: BorderRadius.circular(16)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryColor ),
          borderRadius: BorderRadius.circular(16)
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color:Colors.red.shade900),
            borderRadius: BorderRadius.circular(16)
        ),
        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.grey.shade400),
      ),
      validator: (value){
        if (value == null || value.isEmpty) {
          return "Please Enter Required info.";
        }
        return null;
      },


    );
  }
}