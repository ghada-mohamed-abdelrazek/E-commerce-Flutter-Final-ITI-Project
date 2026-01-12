import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_project/core/resources/app_loading.dart';
import 'package:iti_final_project/core/resources/snack_bar.dart';
import 'package:iti_final_project/feature/auth/auth_cubit.dart';
import 'package:iti_final_project/feature/auth/login/view.dart';
import 'package:iti_final_project/feature/widget/custom_password_field.dart';
import '../../../core/resources/app_color.dart';
import '../../../core/resources/app_field.dart';
import '../../../core/resources/app_images.dart';
import '../../homenav/navigation_botton.dart';


class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if(state is SignUpFailure){
              showMySnackBar(msg:"SignUp Failed", type: AnimatedSnackBarType.error, context: context);
            }
            if(state is SignUpSuccess){
              showMySnackBar(msg: "Sign Up Success", type: AnimatedSnackBarType.success, context: context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) {
                        return HomeNav();
                      }));
            }          },
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
                      Text("Email",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff1A1A1A)),
                      ),
                      AppField(
                          hintText: "user@gmail.com",
                          endIcon: SizedBox(),
                          controller: cubit.emailController,
                      ),
                      SizedBox(height: 12),
                      Text("Password",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff1A1A1A)),
                      ),
                      CustomPasswordField(
                        hint: "*********",
                        controller: cubit.passwordController,
                      ),
                      SizedBox(height: 12),
                      Text("Confirm Password",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff1A1A1A)),
                      ),
                      CustomPasswordField(
                        hint: "*********",
                        controller: cubit.passwordController,
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          cubit.signUp();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          fixedSize: Size(350, 50),
                        ),
                        child: Text("Create account",
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
                          Text("Don’t have an account?  ",
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
                                        return Login();
                                      }));
                            },
                            child: Text("Login",
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
