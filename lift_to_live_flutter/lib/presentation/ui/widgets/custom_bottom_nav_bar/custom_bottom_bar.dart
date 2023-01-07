import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/custom_bottom_nav_bar/custom_bottom_bar_body.dart';
import 'package:lift_to_live_flutter/presentation/views/home_page_view.dart';

import '../../../../helper.dart';
import 'custom_bottom_bar_item.dart';

/// A custom Bottom navigational bar widget, placed on the home page and used for navigation.
class CustomBottomBar extends StatelessWidget {
  final HomePageView view;

  const CustomBottomBar({super.key, required this.view});

  @override
  Widget build(BuildContext context) {
    return BottomExpandableAppBar(
      bottomAppBarColor: Helper.pageBackgroundColor,
      expandedHeight: 230,
      expandedBody: CustomBottomBarBody(view: view),
      shape: const CircularNotchedRectangle(), //shape of notch
      notchMargin: 5, //notch margin between floating button and bottom appbar
      //children inside bottom appbar
      bottomAppBarBody: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomBottomBarItem(
              function: view.habitsPressed, title: 'Habits', icon: Icons.task),
          CustomBottomBarItem(
              function: view.historyPressed,
              title: 'History',
              icon: Icons.edit_calendar),
          const SizedBox(),
          const SizedBox(),
          CustomBottomBarItem(
              function: view.traineesPressed,
              title: 'Trainees',
              icon: Icons.people),
          CustomBottomBarItem(
              function: view.profilePressed,
              title: 'Profile',
              icon: CupertinoIcons.profile_circled),
        ],
      ),
    );
  }
}
