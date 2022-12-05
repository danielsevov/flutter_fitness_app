import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/helper.dart';
import 'package:lift_to_live_flutter/presentation/views/home_page_view.dart';

/// Custom AlertDialog widget, which is nested in the HomePage and is used for logging out of the app.
class LogOutDialog extends StatefulWidget {
  final HomePageView view;

  const LogOutDialog({Key? key, required this.view}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LogOutDialogState();
  }
}

/// This class holds data and methods related to the log in form.
class LogOutDialogState extends State<LogOutDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Helper.paragraphBackgroundColor,
      title: const Text("Sign out", style: TextStyle(color: Helper.defaultTextColor),),
      content: const Text(
          "Are you sure you want to sign out?", style: TextStyle(color: Helper.defaultTextColor),),
      actions: [
        IconButton(
            onPressed: () {
              widget.view.logOutPressed(context);
            },
            icon: const Icon(
              Icons.check_circle,
              color: Helper.confirmButtonColor,
              size: 30,
            )),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.cancel,
              color: Helper.cancelButtonColor,
              size: 30,
            ))
      ],
    );
  }

}