import 'package:first_solo_flutter_app/models/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api_services.dart';
import '../helper.dart';
import '../models/user.dart';
import '../pages/photos_route.dart';
import '../pages/trainees_route.dart';
import '../pages/user_profile_route.dart';
import 'detail_screen.dart';

class TraineeHolder extends StatelessWidget {
  final Image curImg;
  final User user;
  final String userId;

  const TraineeHolder({Key? key, required this.curImg, required this.user, required this.userId}) : super(key: key);


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
                child: ClipRRect(child: curImg, borderRadius: BorderRadius.circular(15.0),),
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
                        Helper.replacePage(context, UserProfileRoute(userId: user.id, nextPage: TraineesRoute(userId: userId), fromHome: false,));
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
