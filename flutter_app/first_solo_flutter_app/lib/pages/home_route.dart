import 'package:first_solo_flutter_app/main.dart';
import 'package:first_solo_flutter_app/pages/login_route.dart';
import 'package:flutter/material.dart';

import 'habits_route.dart';
import 'package:first_solo_flutter_app/Helper.dart';

//home page hub
class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //row for the log out button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  //on pressed clear token and navigate to log in page
                  onPressed: () async {
                    MyApp.jwtToken = "";
                    Helper.pushPage(context, const LogInRoute());
                  },
                  icon: const Icon(
                    Icons.logout,
                    size: 40,
                    color: Colors.black,
                  )),
              const SizedBox(
                width: 20,
                height: 30,
              )
            ],
          ),
          //container for the logo image
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/images/lifttolive.png',
                height: MediaQuery.of(context).size.height / 1.3),
          ),
          //row for the bottom buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Habits button
              TextButton(
                onPressed: () {
                  Helper.pushPage(
                      context,
                      HabitsRoute(
                        userId: MyApp.userId,
                      ));
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(
                      top: 35, bottom: 35, left: 20, right: 20),
                  backgroundColor: Helper.blueColor,
                ),
                child: const Text(
                  'Habits',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              //Start Workout button
              TextButton(
                onPressed: () {
                  // Navigate back to first route when tapped.
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(
                      top: 35, bottom: 35, left: 20, right: 20),
                  backgroundColor: Colors.black,
                ),
                child: const Text(
                  'Start Workout',
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
              ),
              //Profile button
              TextButton(
                onPressed: () {
                  // Navigate back to first route when tapped.
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(
                      top: 35, bottom: 35, left: 20, right: 20),
                  backgroundColor: Helper.redColor,
                ),
                child: const Text(
                  'Profile',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
