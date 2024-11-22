import 'package:firebase_auth_example/feature/authorization/cubit/auth_cubit.dart';
import 'package:firebase_auth_example/feature/authorization/pages/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static const String path = '/sign_up';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Sign up'),
        trailing: CupertinoButton(
          onPressed: () => context.go(SignInPage.path),
          padding: EdgeInsets.zero,
          child: const Text('Log in'),
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
                  context.read<AuthCubit>().signUp(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
