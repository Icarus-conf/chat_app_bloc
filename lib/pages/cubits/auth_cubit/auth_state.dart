part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginFailure extends AuthState {
  String errMsg;

  LoginFailure({required this.errMsg});
}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class RegisterFailure extends AuthState {
  final String errMsg;

  RegisterFailure({required this.errMsg});
}
