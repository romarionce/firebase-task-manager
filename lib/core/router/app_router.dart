import 'dart:developer';

import 'package:firebase_auth_example/core/config/config.dart';
import 'package:firebase_auth_example/core/router/app_router_guards.dart';
import 'package:firebase_auth_example/core/router/app_router_key.dart';
import 'package:firebase_auth_example/feature/authorization/pages/sign_in_page.dart';
import 'package:firebase_auth_example/feature/authorization/pages/sign_up_page.dart';
import 'package:firebase_auth_example/feature/settings/pages/settings_page.dart';
import 'package:firebase_auth_example/feature/task/cubit/task_list/task_list_cubit.dart';
import 'package:firebase_auth_example/feature/task/pages/new_task_page.dart';
import 'package:firebase_auth_example/feature/task/pages/task_list_page.dart';
import 'package:firebase_auth_example/feature/task/repository/task_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRouter {
  static final router = GoRouter(
    navigatorKey: AppRouterKey.rootKey,
    initialLocation: SignInPage.path,
    debugLogDiagnostics: true,
    redirect: (context, state) => null,
    routes: [
      ShellRoute(
        navigatorKey: AppRouterKey.dashboardKey,
        redirect: AppRouterGuards.authorized,
        builder: (context, state, child) => BlocProvider(
          create: (context) {
            log("BUILDER AUTHORIZED");
            //* получаем конфигурацию приложения
            final appConfiguration = AppConfiguration.i(context).state;

            final firestore = appConfiguration.firestoreInstance;

            //* currentUser! используется  потому что мы уже авторизованы
            final user = appConfiguration.authInstance.currentUser!;

            //* taskRepository - умеет обращаться с Task'ами
            final taskRepository =
                TaskRepository(firestore: firestore, user: user);

            return TaskListCubit(taskRepository);
          },
          child: child,
        ),
        routes: [
          GoRoute(
            path: TaskListPage.path,
            builder: (context, state) => const TaskListPage(),
          ),
          GoRoute(
            path: NewTaskPage.path,
            builder: (context, state) => const NewTaskPage(),
          ),
          GoRoute(
            path: SettingsPage.path,
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
      ShellRoute(
        navigatorKey: AppRouterKey.signKey,
        builder: (context, state, child) => child,
        redirect: AppRouterGuards.unauthorized,
        routes: [
          GoRoute(
            path: SignInPage.path,
            builder: (context, state) => const SignInPage(),
          ),
          GoRoute(
            path: SignUpPage.path,
            builder: (context, state) => const SignUpPage(),
          ),
        ],
      )
    ],
  );
}
