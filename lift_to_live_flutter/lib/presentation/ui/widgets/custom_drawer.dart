import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/presentation/views/home_page_view.dart';

import '../../../helper.dart';

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
            height: view.screenHeight / 7 * 4,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                  color: Helper.pageBackgroundColor,
                  borderRadius:
                  BorderRadius.only(topRight: Radius.circular(90))),
              child: Wrap(
                children: [
                  view.screenHeight > 300
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: view.isFetched
                              ? view.profilePicture
                              : Image.asset(
                              'assets/images/prof_pic.png',
                              height: 100),
                        ),
                      ),
                    ],
                  )
                      : const SizedBox(),
                  const SizedBox(
                    height: 20,
                    width: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        view.isFetched ? view.userData.name : '',
                        style: const TextStyle(
                            color: Helper.defaultTextColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  view.screenHeight > 520
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.email_outlined,
                                      color: Helper.yellowColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      view.isFetched ? view.userData.email : '',
                                      style: const TextStyle(
                                          color:
                                          Helper.defaultTextColor,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.phone,
                                      color: Helper.yellowColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      view.isFetched
                                          ? view.userData.phoneNumber
                                          : '',
                                      style: const TextStyle(
                                          color:
                                          Helper.defaultTextColor,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.location_solid,
                                      color: Helper.yellowColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      view.isFetched
                                          ? view.userData.nationality
                                          : '',
                                      style: const TextStyle(
                                          color:
                                          Helper.defaultTextColor,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                      : const SizedBox(),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                ],
              ),
            ),
          ),
          ListTile(
            tileColor: Helper.blueColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(0)),
            ),
            title: Row(
              children: const [
                Icon(
                  CupertinoIcons.profile_circled,
                  color: Helper.yellowColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'My Profile',
                  style: TextStyle(
                    fontSize: 22,
                    color: Helper.defaultTextColor,
                  ),
                )
              ],
            ),
            onTap: () {
              view.profilePressed(context, false);
            },
          ),
          ListTile(
            tileColor: Helper.lightBlueColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(0),
                  topRight: Radius.circular(0)),
            ),
            title: Row(
              children: const [
                Icon(Icons.task_alt_outlined, color: Helper.yellowColor),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'My Habits',
                  style:
                  TextStyle(fontSize: 22, color: Helper.defaultTextColor),
                )
              ],
            ),
            onTap: () async {
              view.habitsPressed(context, false);
            },
          ),
          ListTile(
            tileColor: Helper.blueColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(0)),
            ),
            title: Row(
              children: const [
                Icon(
                  Icons.fitness_center_outlined,
                  color: Helper.yellowColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Manage Workouts',
                  style: TextStyle(
                    fontSize: 22,
                    color: Helper.defaultTextColor,
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            tileColor: Helper.lightBlueColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(0)),
            ),
            title: Row(
              children: const [
                Icon(
                  Icons.people,
                  color: Helper.yellowColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Manage Trainees',
                  style: TextStyle(
                    fontSize: 22,
                    color: Helper.defaultTextColor,
                  ),
                )
              ],
            ),
            onTap: () {
              view.traineesPressed(context, false);
            },
          ),
        ],
      ),
    );
  }
}