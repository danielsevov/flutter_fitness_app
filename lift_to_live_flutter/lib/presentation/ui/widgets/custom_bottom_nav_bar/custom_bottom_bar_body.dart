import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/presentation/views/home_page_view.dart';

import '../../../../helper.dart';

/// A custom Bottom navigational bar body widget, placed on the home page and used for navigation.
class CustomBottomBarBody extends StatelessWidget {
  final HomePageView view;

  const CustomBottomBarBody({super.key, required this.view});

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: view.screenWidth ,
      padding: const EdgeInsets.all(20),
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
                onPressed: () {
                  view.workoutPressed(true);
                  DefaultBottomBarController.of(context).close();
                },
                icon: const Icon(
                  Icons.fitness_center,
                  color: Helper.blackColor,
                ),
                backgroundColor: Helper.yellowColor,
                label: const Text(
                  'Start Workout',
                  style: TextStyle(fontSize: 24, color: Helper.blackColor, fontWeight: FontWeight.w700),
                )),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton.extended(
                heroTag: 'editTemplatesButton',
                onPressed: () {
                  view.templatesPressed(true);
                  DefaultBottomBarController.of(context).close();
                },
                icon: const Icon(Icons.view_carousel),
                backgroundColor: Helper.redColor,
                label: const Text(
                  'Templates',
                  style: TextStyle(
                      fontSize: 24, color: Helper.paragraphTextColor),
                )),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton.extended(
                heroTag: 'viewHistoryButton',
                onPressed: () {
                  view.historyPressed(true);
                  DefaultBottomBarController.of(context).close();
                },
                icon: const Icon(Icons.history),
                backgroundColor: Helper.blackColor,
                label: const Text(
                  'History',
                  style: TextStyle(
                      fontSize: 24, color: Helper.paragraphTextColor),
                )),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
