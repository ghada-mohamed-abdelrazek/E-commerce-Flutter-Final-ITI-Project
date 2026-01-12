import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_project/core/network/fake_dio_helper.dart';
import 'package:iti_final_project/core/resources/cache_helper.dart';

import '../../core/network/dio_helper.dart';
import '../../core/network/end_points.dart';
import '../model/user_token.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Future<void> login() async {
    try {
      emit(LoginLoading());
      final Response response = await DioHelperFake.postRequest(
          endPoint: AppEndPoints.login,
          data: {
            "username": userNameController.text.trim(),
            "password": passwordController.text,

          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        UserToken model = UserToken.fromJson(response.data);
        print("=================${response.statusCode}");

        if (model.token != null) {
          await CacheHelper.saveToken(model.token!);
        } else {
          emit(LoginFailure("No Token Found"));
        }
        emit(LoginSuccess());
        print("=================${model.token}");
      } else {
        emit(LoginFailure(response.data.toString()));
      }
    } on DioException catch (e) {
      emit(LoginFailure(e.message ?? ""));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> signUp() async {
    emit(SignUpLoading());
    try {
      Response response = await DioHelperFake.postRequest(
        endPoint: AppEndPoints.signUp,
        data: {
          "id": 20,
          "username": userNameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),

        },
      );
      emit(SignUpSuccess());
    }catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
}
