import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/presentation/presenters/picture_page_presenter.dart';

import '../../../../helper.dart';
import '../reusable_elements/custom_dialog.dart';
import 'detail_screen.dart';

/// Holder widget for a single image, placed on the user pictures page view.
class MyImageHolder extends StatelessWidget {
  final Image img;
  final String date;
  final int id;
  final PicturePagePresenter presenter;

  const MyImageHolder(
      {Key? key,
      required this.img,
      required this.date,
      required this.id,
      required this.presenter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Helper.lightBlueColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Helper.whiteColor.withOpacity(0.3), width: 0.75)),
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
                          return CustomDialog(
                              title: 'Delete image',
                              bodyText:
                                  'Are you sure you want to delete this image?',
                              confirm: () {
                                presenter.deleteImage(id);
                                Navigator.pop(context);
                              },
                              cancel: () {
                                Navigator.pop(context);
                              });
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
