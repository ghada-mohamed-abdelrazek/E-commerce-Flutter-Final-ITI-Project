import 'package:flutter/material.dart';
import '../../core/resources/app_color.dart';
import '../../core/resources/app_field.dart';

class CustomPasswordField extends StatefulWidget {
  CustomPasswordField({super.key, required this.hint, this.controller});
  final String hint;
  final TextEditingController?controller;


  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return AppField(
      controller: widget.controller,
      obsureText: isHidden,
      hintText: widget.hint,
      endIcon: GestureDetector(
        onTap: (){
          setState(() {
            isHidden =! isHidden;
          });
        },
        child: isHidden?
             Icon(Icons.visibility_off_rounded,color: Colors.black,)
            :Icon(Icons.remove_red_eye_rounded,color: AppColor.primaryColor ,)

        ,
      ),
    );
  }
}
