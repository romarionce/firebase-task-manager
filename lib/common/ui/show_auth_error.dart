import 'package:firebase_auth_example/core/router/app_router_key.dart';
import 'package:firebase_auth_example/feature/authorization/cubit/auth_cubit_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

abstract final class ErrorSnackbar {
  static Future<void> showAuthError(AuthCubitUnauthorized state) {
    return showCupertinoModalPopup(
      context: AppRouterKey.rootKey.currentContext!,
      builder: (context) => CupertinoPopupSurface(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          child: CupertinoButton(
            onPressed: context.canPop,
            child: Text(
              state.error.toString(),
              style: const TextStyle(color: CupertinoColors.systemRed),
            ),
          ),
        ),
      ),
    );
  }
}
