import 'dart:convert';
import 'dart:io';

import 'package:first_solo_flutter_app/pages/photos_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../api_services.dart';
import '../helper.dart';
import '../models/image.dart';
import '../models/user.dart';
import 'habits_route.dart';

class UserProfileRoute extends StatefulWidget {
  const UserProfileRoute({super.key, required this.userId, required this.nextPage, required this.fromHome});
  final String userId;
  final Widget nextPage;
  final bool fromHome;

  @override
  State<UserProfileRoute> createState() => _UserProfileRouteState();
}
class _UserProfileRouteState extends State<UserProfileRoute> {
  late Future<void> future;
  late double screenHeight, screenWidth;

  var name = "", nationality = "", phone = "", birthday = "", coach = "", email = "";
  var img = Image.asset('assets/images/prof_pic.png', height: 300,);
  var imgId = 0;

  @override
  void initState() {
    future = initializePage();
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
              floatingActionButton: FloatingActionButton.extended(
                heroTag: 'btn5',
                backgroundColor: Helper.redColor,
                icon: const Icon(Icons.task),
                label: const Text('Habits'),
                onPressed: () {
                  Helper.pushPageWithAnimation(context, HabitsRoute(userId: widget.userId));
                },
              ),
              appBar: AppBar(
                centerTitle: true,
                title: Text(name),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white, //change your color here
                ),
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      if(widget.fromHome) {
                        Navigator.pop(context);
                      }
                      else {
                        Helper.replacePage(context, widget.nextPage);
                      }
                    }
                ),
                actions: [
                  IconButton(
                      onPressed: () async {
                        Helper.pushPageWithAnimation(context, PhotosRoute(userId: widget.userId));
                      },
                      icon: const Icon(
                        Icons.photo_library_rounded,
                        color: Colors.white,
                      )),
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(image: DecorationImage(
                    image: AssetImage("assets/images/whitewaves.png"),
                    fit: BoxFit.fill,
                  ),),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          APIServices.userId == widget.userId ? const SizedBox(width: 50,) : const SizedBox(),
                          Container(
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: img,
                            ),
                          ),
                          APIServices.userId == widget.userId ? IconButton(onPressed: () async {
                            _changeProfilePicture();
                          }, icon: const Icon(CupertinoIcons.camera_fill, color: Colors.black, size: 30,)) : const SizedBox()
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                            width: 400,
                            decoration: BoxDecoration(
                                color: Helper.blueColor,
                                borderRadius: BorderRadius.circular(30)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.email_outlined,
                                          color: Colors.white, size: 35,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          email,
                                          style: const TextStyle(
                                              color: Colors.white, fontSize: 18),
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
                                          color: Colors.white, size: 35,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          phone,
                                          style: const TextStyle(
                                              color: Colors.white, fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(CupertinoIcons.location_solid,
                                            color: Colors.white, size: 35),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          nationality,
                                          style: const TextStyle(
                                              color: Colors.white, fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.date_range,
                                            color: Colors.white, size: 35),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          birthday,
                                          style: const TextStyle(
                                              color: Colors.white, fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.fitness_center_outlined,
                                          color: Colors.white, size: 35,),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          coach,
                                          style: const TextStyle(
                                              color: Colors.white, fontSize: 18),
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
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }

        // Displaying LoadingSpinner to indicate waiting state
        return const Center(child: CircularProgressIndicator(color: Helper.blueColor,),);
      },
    );
  }

  Future<void> initializePage() async {
    await APIServices.fetchUser(
        widget.userId,
            (res) => {
          name = User.fromJson(jsonDecode(res.body)).name,
          email = User.fromJson(jsonDecode(res.body)).id,
          coach = User.fromJson(jsonDecode(res.body)).coach_id,
          birthday = "born on ${User.fromJson(jsonDecode(res.body)).date_of_birth}",
          nationality = User.fromJson(jsonDecode(res.body)).nationality,
          phone = User.fromJson(jsonDecode(res.body)).phone_number,
          APIServices.fetchUser(
              coach,
                  (res) => {
                coach = "coached by ${User.fromJson(jsonDecode(res.body)).name}",
              }),
        });

    await APIServices.fetchProfileImage(
        widget.userId,
            (res) => {
          if(res.body.length > 2) {
            imgId = MyImage.fromJson(jsonDecode(res.body)[0]).id,
            img = Image.memory(
              base64Decode(MyImage.fromJson(jsonDecode(res.body)[0]).data),
              height: 300,
              scale: 3,
            ),
          }
        });

    refresh();
  }

  /// Get from camera
  _changeProfilePicture() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String encoded = Helper.imageToBlob(imageFile);

      if(imgId != 0) {
        APIServices.patchImage(imgId, widget.userId, (DateTime.now().millisecondsSinceEpoch).toString(), encoded, "profile");
      }

      else {
        APIServices.postImage(widget.userId, (DateTime.now().millisecondsSinceEpoch).toString(), encoded, "profile");
      }
      img = Image.file(
        imageFile,
        height: screenWidth/4*3,
      );

      refresh();
    }
  }

  void refresh() {
    setState(() {});
  }
}