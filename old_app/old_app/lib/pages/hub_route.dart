import 'dart:convert';

import 'package:first_solo_flutter_app/pages/sign_in_route.dart';
import 'package:first_solo_flutter_app/pages/trainees_route.dart';
import 'package:first_solo_flutter_app/pages/user_profile_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api_services.dart';
import '../helper.dart';
import '../models/image.dart';
import '../models/user.dart';
import 'habits_route.dart';

class HubRoute extends StatefulWidget {
  const HubRoute({Key? key}) : super(key: key);

  @override
  State<HubRoute> createState() => _HubRouteState();
}

class _HubRouteState extends State<HubRoute> {
  late Future<void> future;
  var name = "", nationality = "", phone = "";
  var img = Image.asset('assets/images/prof_pic.png', height: 100);
  late double screenHeight, screenWidth;

  @override
  void initState() {
    future = initializeDrawer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //get screen size values
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If we got an error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error} occurred',
                style: const TextStyle(fontSize: 18),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white, //change your color here
                ),
                title: const Text(
                  "LiftToLive",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                actions: [
                  IconButton(
                      //on pressed clear token and navigate to log in page
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Sign out"),
                                content: const Text(
                                    "Are you sure you want to sign out?"),
                                actions: [
                                  IconButton(
                                      onPressed: () {
                                        APIServices.jwtToken = "";
                                        APIServices.myRoles.clear();
                                        APIServices.userId = "";
                                        Helper.pushPageWithAnimation(
                                            context, const SignInPage());
                                      },
                                      icon: const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 30,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                        size: 30,
                                      ))
                                ],
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      )),
                ],
              ),

              floatingActionButton: FloatingActionButton(
                //Floating action button on Scaffold
                onPressed: () {
                  //code to execute on button press
                },
                backgroundColor: Helper.redColor,
                child: const Icon(
                    Icons.fitness_center_outlined), //icon inside button
              ),

              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              //floating action button position to center

              bottomNavigationBar: BottomAppBar(
                //bottom navigation bar on scaffold
                color: Helper.blueColor,
                shape: const CircularNotchedRectangle(), //shape of notch
                notchMargin:
                    5, //notche margin between floating button and bottom appbar
                child: Row(
                  //children inside bottom appbar
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox.fromSize(
                      size: const Size(60, 60),
                      child: ClipOval(
                        child: InkWell(
                          splashColor: Colors.white,
                          onTap: () {
                            Helper.pushPageWithAnimation(
                                context,
                                HabitsRoute(
                                  userId: APIServices.userId,
                                ));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                Icons.task,
                                color: Colors.white,
                              ), // <-- Icon
                              Text(
                                "Habits",
                                style: TextStyle(color: Colors.white),
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
                          splashColor: Colors.white,
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                Icons.edit_calendar,
                                color: Colors.white,
                              ), // <-- Icon
                              Text(
                                "Calendar",
                                style: TextStyle(color: Colors.white),
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
                          splashColor: Colors.white,
                          onTap: () {
                            if(APIServices.myRoles.any((element) =>
                            element.name == "coach" || element.name == "admin")) {
                              Helper.pushPageWithAnimation(
                                  context,
                                  TraineesRoute(
                                    userId: APIServices.userId,
                                  ));
                            }
                            else {
                              Helper.makeToast(context, "Become coach to access this page!");
                            }

                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                Icons.people,
                                color: Colors.white,
                              ), // <-- Icon
                              Text(
                                "Trainees",
                                style: TextStyle(color: Colors.white),
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
                          splashColor: Colors.white,
                          onTap: () {
                            Helper.pushPageWithAnimation(
                                context,
                                UserProfileRoute(
                                  userId: APIServices.userId,
                                  nextPage: const HubRoute(), fromHome: true
                                ));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                CupertinoIcons.profile_circled,
                                color: Colors.white,
                              ), // <-- Icon
                              Text(
                                "Profile",
                                style: TextStyle(color: Colors.white),
                              ), // <-- Text
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/whitewaves.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'assets/images/lifttolive.png',
                    height: screenHeight / 1.5,
                  ),
                ),
              ),
              drawer: Drawer(
                width: screenWidth > 300 ? 300 : screenWidth / 2,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(90),
                      bottomRight: Radius.circular(0)),
                ),
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(
                      height: screenHeight / 2,
                      child: DrawerHeader(
                        decoration: const BoxDecoration(
                            color: Helper.blueColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(90))),
                        child: Wrap(
                          children: [
                            screenHeight > 300
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          child: img,
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 10,
                              width: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            screenHeight > 520
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                      color: Colors.white,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      APIServices.userId,
                                                      style: const TextStyle(
                                                          color: Colors.white70,
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
                                                      color: Colors.white,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      phone,
                                                      style: const TextStyle(
                                                          color: Colors.white70,
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
                                                        CupertinoIcons
                                                            .location_solid,
                                                        color: Colors.white),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      nationality,
                                                      style: const TextStyle(
                                                          color: Colors.white70,
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
                          Icon(CupertinoIcons.profile_circled,
                              color: Colors.white),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'My Profile',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          )
                        ],
                      ),
                      textColor: Helper.blueColor,
                      onTap: () {
                        Navigator.pop(context);
                        Helper.pushPageWithAnimation(
                            context,
                            UserProfileRoute(
                              userId: APIServices.userId,
                              nextPage: const HubRoute(),
                              fromHome: true,
                            ));
                      },
                    ),
                    ListTile(
                      tileColor: Helper.redColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(0),
                            topRight: Radius.circular(0)),
                      ),
                      title: Row(
                        children: const [
                          Icon(Icons.task_alt_outlined, color: Colors.white),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'My Habits',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          )
                        ],
                      ),
                      textColor: Helper.redColor,
                      onTap: () async {
                        Navigator.pop(context);
                        Helper.pushPageWithAnimation(
                            context,
                            HabitsRoute(
                              userId: APIServices.userId,
                            ));
                      },
                    ),
                    ListTile(
                      tileColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(0)),
                      ),
                      title: Row(
                        children: const [
                          Icon(Icons.fitness_center_outlined,
                              color: Colors.white),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Manage Workouts',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          )
                        ],
                      ),
                      textColor: Colors.black,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    APIServices.myRoles.any((element) =>
                            element.name == "coach" || element.name == "admin")
                        ? ListTile(
                            tileColor: Helper.blueColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(0),
                                  topLeft: Radius.circular(0)),
                            ),
                            title: Row(
                              children: const [
                                Icon(Icons.people, color: Colors.white),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Manage Trainees',
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                )
                              ],
                            ),
                            textColor: Helper.blueColor,
                            onTap: () {
                              Navigator.pop(context);

                              Helper.pushPageWithAnimation(
                                  context,
                                  TraineesRoute(
                                    userId: APIServices.userId,
                                  ));
                            },
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            );
          }
        }

        // Displaying LoadingSpinner to indicate waiting state
        return Column(
          children: [
            AppBar(
              centerTitle: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white, //change your color here
              ),
              title: const Text(
                "LiftToLive",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/images/lifttolive.png',
                  height: screenHeight / 1.5,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void refresh() {
    setState(() {});
  }

  Future<void> initializeDrawer() async {
    await APIServices.fetchUser(
        APIServices.userId,
        (res) => {
              name = User.fromJson(jsonDecode(res.body)).name,
              nationality = User.fromJson(jsonDecode(res.body)).nationality,
              phone = User.fromJson(jsonDecode(res.body)).phone_number,
            });

    await APIServices.fetchProfileImage(
        APIServices.userId,
        (res) => {
              img = Image.memory(
                base64Decode(MyImage.fromJson(jsonDecode(res.body)[0]).data),
                height: 100,
              ),
            });

    refresh();
  }
}
