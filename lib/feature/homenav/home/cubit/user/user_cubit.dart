
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_project/core/network/end_points.dart';
import 'package:iti_final_project/core/network/fake_dio_helper.dart';
import 'package:iti_final_project/feature/model/user_model.dart';

part 'user_state.dart';
class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  UserModel? currentUser;

  Future<void> getUser(int id) async {
    emit(UserLoading());
    try {
      final Response response = await DioHelperFake.getRequest(
        endPoint: "${AppEndPoints.users}/$id",
      );

      final user = UserModel.fromJson(response.data as Map<String, dynamic>);
      currentUser = user;

      emit(UserSuccess(user));
    } on DioException catch (e) {
      final msg = e.response?.data?.toString() ?? e.message ?? "Dio error";
      emit(UserFailure(msg));
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }
}
