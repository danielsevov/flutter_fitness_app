import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      expandedBody: Container(
        width: view.screenWidth * 0.7,
        decoration: const BoxDecoration(
            color: Helper.lightBlueColor,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              FloatingActionButton.extended(
                  heroTag: 'startWorkoutButton',
                  onPressed: () {},
                  icon: const Icon(
                    Icons.fitness_center,
                    color: Helper.blackColor,
                  ),
                  backgroundColor: Helper.yellowColor,
                  label: const Text(
                    'Start Workout',
                    style: TextStyle(fontSize: 24, color: Helper.blackColor),
                  )),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton.extended(
                  heroTag: 'editTemplatesButton',
                  onPressed: () {},
                  icon: const Icon(Icons.edit_note),
                  backgroundColor: Helper.redColor,
                  label: const Text(
                    'Edit Templates',
                    style: TextStyle(
                        fontSize: 24, color: Helper.paragraphTextColor),
                  )),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton.extended(
                  heroTag: 'viewHistoryButton',
                  onPressed: () {},
                  icon: const Icon(Icons.history),
                  backgroundColor: Helper.blackColor,
                  label: const Text(
                    'View History',
                    style: TextStyle(
                        fontSize: 24, color: Helper.paragraphTextColor),
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
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
              function: (context, fromBottomBar) {},
              title: 'Calendar',
              icon: Icons.edit_calendar), // TODO fix navigation
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