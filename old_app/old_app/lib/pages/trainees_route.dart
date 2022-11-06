import 'dart:convert';

import 'package:first_solo_flutter_app/models/image.dart';
import 'package:first_solo_flutter_app/pages/register_route.dart';
import 'package:first_solo_flutter_app/widgets/trainee_holder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api_services.dart';
import '../models/user.dart';
import 'package:first_solo_flutter_app/helper.dart';

//home page hub
class TraineesRoute extends StatefulWidget {
  const TraineesRoute({super.key, required this.userId});

  final String userId;

  @override
  State<TraineesRoute> createState() => _TraineesRouteState();
}

class _TraineesRouteState extends State<TraineesRoute> {
  var users = <User>[];
  var userWidgets = <Widget>[];
  var searchController = TextEditingController();
  late double screenHeight, screenWidth;

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    //get screen size values
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Helper.redColor,
        heroTag: "btn3",
        icon: const Icon(CupertinoIcons.profile_circled),
        label: const Text('Register User'),
        onPressed: () {
          Helper.pushPageWithAnimation(
              context, RegisterRoute(userId: widget.userId));
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Trainees"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/whitewaves.png"),
              fit: BoxFit.fill,
            ),
          ),
          child:
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: screenWidth > 500 ? 500 : screenWidth-20,
                  child: TextField(
                    onTap: (){},
                    onEditingComplete: () {
                      refresh();
                    },
                    controller: searchController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Helper.blueColor, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Helper.blueColor,
                      ),
                      hintText: "Search user",
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontSize: 24, height: 0.8),
                    ),
                    style: const TextStyle(
                        color: Helper.blueColor,
                        fontSize: 20,
                        height: 0.8),
                  ),
                ),
                FutureBuilder<void>(
                  future:
                      _initializeTrainees(), // a previously-obtained Future<String> or null
                  builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                    Widget children;
                    if (snapshot.connectionState != ConnectionState.done) {
                      children = Column(children: const [
                        SizedBox(
                          height: 200,
                        ),
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(color: Helper.redColor,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Loading data...'),
                        ),
                      ]);
                    } else {
                      children = Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          SizedBox(
                            height: screenHeight / 1.2,
                            width: screenWidth > 500 ? 500 : screenWidth,
                            child: ListView(
                                children: userWidgets,
                              ),
                            ),
                        ],
                      );
                    }
                    return Center(
                      child: children,
                    );
                  },
                ),
              ],
            ),
        ),
      ),
    );
  }

  void addUserWidget(User user, Image curImg) {
    if(users.contains(user)) {
      userWidgets
          .add(TraineeHolder(curImg: curImg, user: user, userId: widget.userId));
    }
  }

  Future<void> _initializeTrainees() async {
    users.clear();
    userWidgets.clear();

    var res = await APIServices.fetchUsers();
    List<dynamic> list = json.decode(res.body);

    for (var element in list) {
      users.add(User.fromJson(element));
    }

    //filter only habits for current user
    var filteredUsers = users;
    if (!APIServices.myRoles.map((e) => e.name).contains("admin")) {
      filteredUsers = users
          .where((element) =>
              element.coach_id == APIServices.userId &&
              element.id != APIServices.userId)
          .toList();
    }

    filteredUsers = filteredUsers
        .where((element) =>
            element.id
                .toLowerCase()
                .contains(searchController.text.toString().toLowerCase()) ||
            element.name
                .toLowerCase()
                .contains(searchController.text.toString().toLowerCase()))
        .toList();

    //sort by date
    filteredUsers.sort((a, b) => a.name.compareTo(b.name));

    for (var element in filteredUsers) {
      var curImg = Image.asset(
        'assets/images/prof_pic.png',
        height: 150,
      );
      var res = await APIServices.fetchProfileImage(element.id, (res) => {});

      if (res.body.length > 2) {
        curImg = Image.memory(
          base64Decode(MyImage.fromJson(jsonDecode(res.body)[0]).data),
          height: 150,
          scale: 3,
        );
      }

      addUserWidget(element, curImg);
    }
    userWidgets.add(const SizedBox(height: 120, width: 50,));
  }
}
