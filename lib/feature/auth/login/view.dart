import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_project/core/resources/app_loading.dart';
import 'package:iti_final_project/core/resources/snack_bar.dart';
import 'package:iti_final_project/feature/homenav/navigation_botton.dart';

import '../../../core/resources/app_color.dart';
import '../../../core/resources/app_field.dart';
import '../../../core/resources/app_images.dart';
import '../../../core/resources/app_text_style.dart';
import '../../widget/check_box.dart';
import '../../widget/custom_password_field.dart';
import '../auth_cubit.dart';
import '../sigup/view.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if(state is LoginFailure){
              showMySnackBar(msg:"Username or password is incorrect", type: AnimatedSnackBarType.error, context: context);
            }
            if(state is LoginSuccess){
              showMySnackBar(msg: "Login Success", type: AnimatedSnackBarType.success, context: context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) {
                        return HomeNav();
                      }));
            }
          },
          builder: (context, state) {
            final cubit =context.read<AuthCubit>();
            if(state is LoginLoading){
              return AppLoading();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: [
                      Container(
                        width: 350,
                        height: 150,
                        child: Image.asset(AppImages.auth,
                          fit: BoxFit.cover,

                        ),
                      ),
                      SizedBox(height: 40),
                      Text("Enter User Name",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff1A1A1A)),
                      ),
                      AppField(
                          hintText: "User Name",
                          endIcon: SizedBox(),
                          controller: cubit.userNameController,
                      ),
                      SizedBox(height: 40),
                      Text("Password",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff1A1A1A)),
                      ),
                      CustomPasswordField(
                        hint: "Enter your password",
                        controller: cubit.passwordController,
                      ),
                      SizedBox(height: 12,),
                      Row(
                        children: [
                          CheckBox(),
                          Text("Remember me",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.black
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: Text("Forget password?",
                              style: AppTextStyle.secondaryStyle,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          cubit.login();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          fixedSize: Size(350, 50),
                        ),
                        child: Text("Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?  ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff808080)
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) {
                                        return Signup();
                                      }));
                            },
                            child: Text("Sign up",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff1A1A1A),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
