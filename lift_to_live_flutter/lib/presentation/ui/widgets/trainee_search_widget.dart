import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/presentation/views/trainees_page_view.dart';

import '../../../domain/entities/user.dart';
import '../../../helper.dart';

class TraineeSearchWidget extends StatelessWidget {
  final User user;
  final TraineesPageView view;

  const TraineeSearchWidget({Key? key, required this.user, required this.view}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Helper.blueColor
        ),
        child : Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white
              ),
              child: FittedBox(
                fit: BoxFit.fill,
                child: ClipRRect(borderRadius: BorderRadius.circular(15.0),
                  child: user.profilePicture != null ? Image.memory(
                  base64Decode(user.profilePicture!.data),
                  height: 200,
                ) : Image.asset('assets/images/prof_pic.png'),),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(user.name, style: const TextStyle(color: Colors.white, fontSize: 20)),
                    FittedBox(fit: BoxFit.fitWidth,child: Text(user.id, style: const TextStyle(color: Colors.white)),),
                    const SizedBox(height: 20,),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: IconButton(onPressed: () {
                        view.navigateToProfilePage(user.id);
                      }, icon: const Icon(CupertinoIcons.arrow_right_circle_fill, size: 60, color: Colors.white,)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}