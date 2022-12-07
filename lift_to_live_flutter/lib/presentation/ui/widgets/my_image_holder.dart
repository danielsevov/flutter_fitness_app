import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/presentation/presenters/picture_page_presenter.dart';

import '../../../helper.dart';
import 'detail_screen.dart';

class MyImageHolder extends StatelessWidget {
  final Image img;
  final String date;
  final int id;
  final PicturePagePresenter presenter;

  const MyImageHolder({Key? key, required this.img, required this.date, required this.id, required this.presenter}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Helper.lightBlueColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Helper.dividerColor, width: 1)),
      padding: const EdgeInsets.only(bottom: 4, top: 2, right: 6, left: 6),
      margin: const EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: GestureDetector(
                  child: Hero(
                    tag: '$id',
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
                    int.parse(date) * 1000)),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Helper.defaultTextColor),
              ),
              IconButton(
                  onPressed: () {

                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Helper.paragraphBackgroundColor,
                            title: const Text("Delete image", style: TextStyle(color: Helper.defaultTextColor),),
                            content: const Text(
                                "Are you sure you want to delete this image?", style: TextStyle(color: Helper.defaultTextColor),),
                            actions: [
                              IconButton(onPressed: (){presenter.deleteImage(id);Navigator.pop(context);}, icon: const Icon(Icons.check_circle, color: Helper.confirmButtonColor, size: 30,)),
                              IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.cancel, color: Helper.cancelButtonColor, size: 30,))
                            ],
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.cancel_rounded,
                    color: Helper.cancelButtonColor,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
