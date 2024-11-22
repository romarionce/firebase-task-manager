import 'package:flutter/cupertino.dart';

class CupertinoIconButton extends StatelessWidget {
  const CupertinoIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
  });

  final IconData icon;
  final void Function() onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Icon(icon, color: color),
    );
  }
}
