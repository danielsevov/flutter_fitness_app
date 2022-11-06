import 'dart:convert';
import 'dart:io';

import 'package:first_solo_flutter_app/models/image.dart';
import 'package:first_solo_flutter_app/widgets/my_image_holder.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:first_solo_flutter_app/helper.dart';

import '../api_services.dart';

//home page hub
class PhotosRoute extends StatefulWidget {
  const PhotosRoute({super.key, required this.userId});

  final String userId;

  @override
  State<PhotosRoute> createState() => _PhotosRouteState();
}

class _PhotosRouteState extends State<PhotosRoute> {
  var images = <MyImage>[];
  var frontPics = <Widget>[], backPics = <Widget>[], sidePics = <Widget>[];
  late double screenHeight, screenWidth;

  void addPictureWidget(MyImage image, List<Widget> list) {
    var img = Image.memory(
      base64Decode(image.data),
      height: 260,
      scale: 3,
    );

    if(!images.contains(image)) {
      list.add(MyImageHolder(
          image: image, img: img, images: images, userId: widget.userId));
    }
  }

  /// Get from camera
  _getPictureFromGallery(String type) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String encoded = Helper.imageToBlob(imageFile);

      await APIServices.postImage(widget.userId,
          (DateTime.now().millisecondsSinceEpoch).toString(), encoded, type);
      if (!mounted) return;
      images.clear();
      Helper.replacePage(context, PhotosRoute(userId: widget.userId));
    }
  }

  Future<void> _getPicturesFromAPI() async {
    images.clear();
    frontPics.clear();
    sidePics.clear();
    backPics.clear();

    var res = await APIServices.getImages(widget.userId);
    List<dynamic> list = json.decode(res.body);

    //transform them to Habit instances
    for (var element in list) {
      var img = MyImage.fromJson(element);
      if (img.type == "front" ) {
        addPictureWidget(img, frontPics);
      } else if (img.type == "back") {
        addPictureWidget(img, backPics);
      } else if (img.type == "side") {
        addPictureWidget(img, sidePics);
      }

      images.add(img);
    }
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //get screen size values
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Photo Album"),
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
        child: Column(
          children: [
            FutureBuilder<void>(
              future:
                  _getPicturesFromAPI(), // a previously-obtained Future<String> or null
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
                      child: CircularProgressIndicator(
                        color: Helper.blueColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Loading data...'),
                    ),
                  ]);
                }

                else {
                  children = Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: const DecorationImage(
                          image: AssetImage("assets/images/whitewaves.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            color: Helper.blueColor,
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Front Photos",
                                style: TextStyle(
                                    color: Helper.blueColor, fontSize: 24),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              APIServices.userId == widget.userId
                                  ? CircleAvatar(
                                      backgroundColor: Helper.blueColor,
                                      child: IconButton(
                                          onPressed: () {
                                            _getPictureFromGallery("front");
                                          },
                                          icon: const Icon(Icons.add,
                                              color: Colors.white)),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                          const Divider(
                            color: Helper.blueColor,
                            thickness: 1,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                            height: 360,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: frontPics,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            color: Helper.blueColor,
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Back Photos",
                                style: TextStyle(
                                    color: Helper.blueColor, fontSize: 24),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              APIServices.userId == widget.userId
                                  ? CircleAvatar(
                                      backgroundColor: Helper.blueColor,
                                      child: IconButton(
                                          onPressed: () {
                                            _getPictureFromGallery("back");
                                          },
                                          icon: const Icon(Icons.add,
                                              color: Colors.white)),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                          const Divider(
                            color: Helper.blueColor,
                            thickness: 1,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                            height: 360,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: backPics,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            color: Helper.blueColor,
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Side Photos",
                                style: TextStyle(
                                    color: Helper.blueColor, fontSize: 24),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              APIServices.userId == widget.userId
                                  ? CircleAvatar(
                                      backgroundColor: Helper.blueColor,
                                      child: IconButton(
                                          onPressed: () {
                                            _getPictureFromGallery("side");
                                          },
                                          icon: const Icon(Icons.add,
                                              color: Colors.white)),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                          const Divider(
                            color: Helper.blueColor,
                            thickness: 1,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                            height: 360,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: sidePics,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ));
                }
                return Center(
                  child: children,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
