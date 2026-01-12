part of 'user_cubit.dart';

abstract class UserState {}

final class UserInitial extends UserState {}
final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final UserModel user;
  UserSuccess(this.user);
}

final class UserFailure extends UserState {
  final String message;
  UserFailure(this.message);
}
