import 'package:flutter/material.dart';

import '../../../../helper.dart';


/// A custom Bottom navigational bar item widget, placed on the home page bottom nav bar and used for navigation.
class CustomBottomBarItem extends StatelessWidget {
  final Function(BuildContext context, bool fromBottomBar) function;
  final String title;
  final IconData icon;

  const CustomBottomBarItem({super.key, required this.function, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(60, 60),
      child: ClipOval(
        child: InkWell(
          splashColor: Helper.whiteColor,
          onTap: () {
            function(context, true);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: Helper.bottomBarIconColor,
              ), // <-- Icon
              Text(
                title,
                style: const TextStyle(color: Helper.bottomBarTextColor),
              ), // <-- Text
            ],
          ),
        ),
      ),
    );
  }
}