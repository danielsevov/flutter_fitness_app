import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../helper.dart';

/// Custom drawer header item, part of the home page drawer header.
class CustomDrawerHeaderItem extends StatelessWidget {
  final bool isFetched;
  final String title;
  final IconData icon;

  const CustomDrawerHeaderItem({
    super.key,
    required this.isFetched,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Helper.yellowColor,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          isFetched ? title : '',
          style: const TextStyle(color: Helper.defaultTextColor, fontSize: 14),
        ),
      ],
    );
  }
}
