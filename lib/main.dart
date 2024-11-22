import 'dart:developer';

import 'package:firebase_auth_example/common/ui/show_auth_error.dart';
import 'package:firebase_auth_example/core/config/config.dart';
import 'package:firebase_auth_example/core/router/app_router.dart';
import 'package:firebase_auth_example/feature/authorization/cubit/auth_cubit.dart';
import 'package:firebase_auth_example/feature/authorization/cubit/auth_cubit_state.dart';
import 'package:firebase_auth_example/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  log('START APP...');
  runApp(const _MyApp());
}

class _MyApp extends StatelessWidget {
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //? Создаем глобальные Cubit
      providers: [
        BlocProvider(create: (_) => AppConfiguration()),
        BlocProvider(
          create: (context) => AuthCubit(
            firebaseAuth: AppConfiguration.i(context).state.authInstance,
          ),
        ),
      ],

      //? При изменении состояния авторизации
      child: BlocListener<AuthCubit, AuthCubitState>(
        listener: (context, state) {
          if (state is AuthCubitUnauthorized) {
            if (state.error != null) ErrorSnackbar.showAuthError(state);
          }
          AppRouter.router.refresh();
        },
        child: CupertinoApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
