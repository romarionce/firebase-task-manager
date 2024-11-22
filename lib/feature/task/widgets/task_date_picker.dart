import 'package:flutter/cupertino.dart';

class TaskDatePicker extends StatelessWidget {
  const TaskDatePicker({
    super.key,
    this.initialDateTime,
    required this.onDateChanged,
  });

  final DateTime? initialDateTime;
  final void Function(DateTime newDate) onDateChanged;
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text('Select a date'),
      actions: <Widget>[
        SizedBox(
          height: 250,
          child: CupertinoDatePicker(
            initialDateTime: initialDateTime,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: onDateChanged,
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
    );
  }
}
