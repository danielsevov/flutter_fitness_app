import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/helper.dart';

/// Custom AlertDialog widget.
class CustomDialog extends StatelessWidget {
  final String title, bodyText;
  final Function() confirm, cancel;

  const CustomDialog(
      {Key? key,
      required this.title,
      required this.bodyText,
      required this.confirm,
      required this.cancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Helper.paragraphBackgroundColor,
      title: Text(
        title,
        style: const TextStyle(color: Helper.defaultTextColor),
      ),
      content: Text(
        bodyText,
        style: const TextStyle(color: Helper.defaultTextColor),
      ),
      actions: [
        IconButton(
            onPressed: confirm,
            icon: const Icon(
              Icons.check_circle,
              color: Helper.confirmButtonColor,
              size: 30,
            )),
        IconButton(
            onPressed: cancel,
            icon: const Icon(
              Icons.cancel,
              color: Helper.cancelButtonColor,
              size: 30,
            ))
      ],
    );
  }
}
