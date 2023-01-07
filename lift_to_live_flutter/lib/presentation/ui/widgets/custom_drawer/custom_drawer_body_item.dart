import 'package:flutter/material.dart';

import '../../../../helper.dart';

/// Custom drawer body item widget used for navigation, placed on the home page drawer.
class CustomDrawerBodyItem extends StatelessWidget {
  final Function(bool fromBottomBar) function;
  final String title;
  final IconData icon;
  final Color tileColor;

  const CustomDrawerBodyItem(
      {super.key,
      required this.function,
      required this.title,
      required this.icon,
      required this.tileColor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: tileColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(0), topLeft: Radius.circular(0)),
      ),
      title: Row(
        children: [
          Icon(
            icon,
            color: Helper.yellowColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              color: Helper.defaultTextColor,
            ),
          )
        ],
      ),
      onTap: () {
        function(false);
      },
    );
  }
}
