import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/presentation/views/home_page_view.dart';

import '../../../helper.dart';

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
          child: Column(children: [
            const SizedBox(height: 60,),
            FloatingActionButton.extended(heroTag: 'startworkoutbutton', onPressed: () {},icon: const Icon(Icons.fitness_center, color: Helper.blackColor,),backgroundColor: Helper.yellowColor, label: const Text('Start Workout', style: TextStyle(fontSize: 24, color: Helper.blackColor),)),
            const SizedBox(height: 10,),
            FloatingActionButton.extended(heroTag: 'edittemplatesbutton', onPressed: () {},icon: const Icon(Icons.edit_note),backgroundColor: Helper.redColor, label: const Text('Edit Templates', style: TextStyle(fontSize: 24, color: Helper.paragraphTextColor),)),
            const SizedBox(height: 10,),
            FloatingActionButton.extended(heroTag: 'viewhistorybutton', onPressed: () {},icon: const Icon(Icons.history),backgroundColor: Helper.blackColor, label: const Text('View History', style: TextStyle(fontSize: 24, color: Helper.paragraphTextColor),)),
            const SizedBox(height: 10,),
          ],),
        ),
      ),
      shape: const CircularNotchedRectangle(), //shape of notch
      notchMargin: 5, //notch margin between floating button and bottom appbar
      //children inside bottom appbar
      bottomAppBarBody: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox.fromSize(
            size: const Size(60, 60),
            child: ClipOval(
              child: InkWell(
                splashColor: Helper.whiteColor,
                onTap: () {
                  view.habitsPressed(context, true);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.task,
                      color: Helper.bottomBarIconColor,
                    ), // <-- Icon
                    Text(
                      "Habits",
                      style: TextStyle(color: Helper.bottomBarTextColor),
                    ), // <-- Text
                  ],
                ),
              ),
            ),
          ),
          SizedBox.fromSize(
            size: const Size(60, 60),
            child: ClipOval(
              child: InkWell(
                splashColor: Helper.whiteColor,
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.edit_calendar,
                      color: Helper.bottomBarIconColor,
                    ), // <-- Icon
                    Text(
                      "Calendar",
                      style: TextStyle(color: Helper.bottomBarTextColor),
                    ), // <-- Text
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(),
          const SizedBox(),
          SizedBox.fromSize(
            size: const Size(60, 60),
            child: ClipOval(
              child: InkWell(
                splashColor: Helper.whiteColor,
                onTap: () {
                  view.traineesPressed(context, true);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.people,
                      color: Helper.bottomBarIconColor,
                    ), // <-- Icon
                    Text(
                      "Trainees",
                      style: TextStyle(color: Helper.bottomBarTextColor),
                    ), // <-- Text
                  ],
                ),
              ),
            ),
          ),
          SizedBox.fromSize(
            size: const Size(60, 60),
            child: ClipOval(
              child: InkWell(
                splashColor: Helper.whiteColor,
                onTap: () {
                  view.profilePressed(context, true);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      CupertinoIcons.profile_circled,
                      color: Helper.bottomBarIconColor,
                    ), // <-- Icon
                    Text(
                      "Profile",
                      style: TextStyle(color: Helper.bottomBarTextColor),
                    ), // <-- Text
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}