import 'package:firebase_auth/firebase_auth.dart';

abstract base class AuthCubitState {}

final class AuthCubitAuthorized implements AuthCubitState {
  final User user;

  AuthCubitAuthorized({required this.user});
}

final class AuthCubitUnauthorized implements AuthCubitState {
  final Object? error;

  AuthCubitUnauthorized({this.error});
}

final class AuthCubitLoading implements AuthCubitState {}
