import 'package:flutter/cupertino.dart';

class CantCreateTaskDialog extends StatelessWidget {
  const CantCreateTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
        title: const Text(
          "You can't save task",
          style: TextStyle(color: CupertinoColors.destructiveRed),
        ),
        content: const Text(
          'Write title or description!',
          style: TextStyle(color: CupertinoColors.destructiveRed),
        ),
        actions: [
          CupertinoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          )
        ]);
  }
}
