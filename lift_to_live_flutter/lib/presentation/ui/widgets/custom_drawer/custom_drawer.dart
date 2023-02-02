import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/custom_drawer/custom_drawer_body_item.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/custom_drawer/custom_drawer_header.dart';
import 'package:lift_to_live_flutter/presentation/views/home_page_view.dart';

import '../../../../helper.dart';

/// Custom drawer widget used for navigation, placed on the home page view.
class CustomDrawer extends StatelessWidget {
  final HomePageView view;

  const CustomDrawer({super.key, required this.view});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: view.screenWidth > 300 ? 300 : view.screenWidth / 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(90), bottomRight: Radius.circular(0)),
      ),
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: view.screenHeight * 0.65,
            child: CustomDrawerHeader(
              view: view,
            ),
          ),
          CustomDrawerBodyItem(
              function: view.profilePressed,
              title: 'My Profile',
              icon: CupertinoIcons.profile_circled,
              tileColor: Helper.blueColor),
          CustomDrawerBodyItem(
              function: view.habitsPressed,
              title: 'My Habits',
              icon: Icons.task_alt_outlined,
              tileColor: Helper.lightBlueColor),
          CustomDrawerBodyItem(
              function: view.historyPressed,
              title: 'View Workouts',
              icon: Icons.fitness_center_outlined,
              tileColor: Helper.blueColor),
          CustomDrawerBodyItem(
              function: view.traineesPressed,
              title: 'Manage Trainees',
              icon: Icons.people,
              tileColor: Helper.lightBlueColor),
        ],
      ),
    );
  }
}
