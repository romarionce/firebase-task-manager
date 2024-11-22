import 'package:firebase_auth_example/feature/authorization/cubit/auth_cubit.dart';
import 'package:firebase_auth_example/feature/authorization/cubit/auth_cubit_state.dart';
import 'package:firebase_auth_example/feature/authorization/pages/sign_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static const String path = '/sign_in';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Sign in'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.go(SignUpPage.path),
          child: const Text('Sign Up'),
        ),
      ),
      child: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoTextField(
                controller: emailController,
                placeholder: 'Enter your email',
                // decoration: const InputDecoration(label: Text('Email')),
              ),
              const SizedBox(height: 10),
              CupertinoTextField(
                controller: passwordController,
                placeholder: 'Enter your password',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                onPressed: () {
                  context.read<AuthCubit>().signIn(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                },
                child: BlocBuilder<AuthCubit, AuthCubitState>(
                  builder: (context, state) {
                    if (state is AuthCubitLoading) {
                      return const SizedBox.square(
                        dimension: 20,
                        child: CupertinoActivityIndicator(),
                      );
                    }
                    return const Text('Log in');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
