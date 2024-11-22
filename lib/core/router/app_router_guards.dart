import 'dart:async';

import 'package:firebase_auth_example/feature/authorization/cubit/auth_cubit.dart';
import 'package:firebase_auth_example/feature/authorization/cubit/auth_cubit_state.dart';
import 'package:firebase_auth_example/feature/authorization/pages/sign_in_page.dart';
import 'package:firebase_auth_example/feature/task/pages/task_list_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

//* Router Guards
abstract final class AppRouterGuards {
  //? Гвард для неавторизованных маршрутов
  static FutureOr<String?> unauthorized(
      BuildContext context, GoRouterState state) {
    final authState = AuthCubit.i(context).state;

    if (authState is AuthCubitAuthorized) {
      return TaskListPage.path;
    }

    return null;
  }

  //? Гвард для авторизованных маршрутов
  static FutureOr<String?> authorized(
      BuildContext context, GoRouterState state) {
    final authState = AuthCubit.i(context).state;

    if (authState is AuthCubitUnauthorized) {
      return SignInPage.path;
    }

    return null;
  }

  //? Гвард для публичных маршрутов
  static FutureOr<String?> public(BuildContext context, GoRouterState state) {
    return null;
  }
}
