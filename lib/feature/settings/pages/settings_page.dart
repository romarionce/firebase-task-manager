import 'package:firebase_auth_example/feature/authorization/cubit/auth_cubit.dart';
import 'package:firebase_auth_example/feature/authorization/cubit/auth_cubit_state.dart';
import 'package:firebase_auth_example/feature/task/pages/task_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const String path = '/settings';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Settings"),
        leading: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => context.go(TaskListPage.path),
            child: const Icon(CupertinoIcons.back)),
      ),
      child: BlocBuilder<AuthCubit, AuthCubitState>(builder: (context, state) {
        if (state is AuthCubitAuthorized) {
          return ListView(
            children: [
              CupertinoListSection(
                header: const Text("Profile"),
                children: [
                  CupertinoListTile(
                    leading: const Icon(CupertinoIcons.profile_circled),
                    title: const Text('Email'),
                    subtitle: Text(state.user.email!),
                  ),
                  //* Fake data
                  const CupertinoListTile(
                    leading: Icon(CupertinoIcons.lock_shield),
                    title: Text("Account status"),
                    subtitle: Text("verified"),
                  ),
                ],
              ),
              CupertinoListSection(
                header: const Text("Account"),
                children: [
                  CupertinoListTile(
                    leading: const Icon(
                      CupertinoIcons.square_arrow_right,
                      color: CupertinoColors.destructiveRed,
                    ),
                    title: const Text('Logout'),
                    onTap: AuthCubit.i(context).signOut,
                  ),
                ],
              )
            ],
          );
        }
        return const SizedBox();
      }),
    );
  }
}
