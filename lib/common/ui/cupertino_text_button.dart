import 'package:flutter/cupertino.dart';

class CupertinoTextButton extends StatelessWidget {
  const CupertinoTextButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
