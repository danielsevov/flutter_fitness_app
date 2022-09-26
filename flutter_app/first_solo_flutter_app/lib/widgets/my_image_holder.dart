import 'package:first_solo_flutter_app/models/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api_services.dart';
import '../helper.dart';
import '../pages/photos_route.dart';
import 'detail_screen.dart';

class MyImageHolder extends StatelessWidget {
  final Image img;
  final MyImage image;
  final List<MyImage> images;
  final String userId;

  const MyImageHolder(
      {super.key,
      required this.image,
      required this.img,
      required this.images,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Helper.blueColor.withOpacity(0.75),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1)),
      padding: const EdgeInsets.only(bottom: 4, top: 2, right: 2, left: 2),
      margin: const EdgeInsets.only(left: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: GestureDetector(
                  child: Hero(
                    tag: '${image.id}',
                    child: img,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) {
                        return DetailScreen(
                          img: img,
                        );
                      }),
                    );
                  })),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Helper.formatter.format(DateTime.fromMicrosecondsSinceEpoch(
                    int.parse(image.date) * 1000)),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
              IconButton(
                  onPressed: () {

                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Delete image"),
                            content: const Text(
                                "Are you sure you want to delete this image?"),
                            actions: [
                              IconButton(onPressed: (){APIServices.deleteImage(image.id);
                              images.clear();
                              Helper.replacePage(context, PhotosRoute(userId: userId));}, icon: const Icon(Icons.check_circle, color: Colors.green, size: 30,)),
                              IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.cancel, color: Colors.red, size: 30,))
                            ],
                          );
                        });
                  },
                  icon: const Icon(
                    CupertinoIcons.delete_solid,
                    color: Helper.redColor,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
