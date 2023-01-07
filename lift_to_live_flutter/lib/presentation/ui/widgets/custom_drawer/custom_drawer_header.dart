import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/custom_drawer/custom_drawer_header_item.dart';
import 'package:lift_to_live_flutter/presentation/views/home_page_view.dart';

import '../../../../helper.dart';

/// Custom drawer header, part of the home page drawer.
class CustomDrawerHeader extends StatelessWidget {
  final HomePageView view;

  const CustomDrawerHeader({super.key, required this.view});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
          color: Helper.pageBackgroundColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(90))),
      child: Wrap(
        children: [
          view.screenHeight > 300
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 150,
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: view.isFetched
                            ? view.profilePicture
                            : Image.asset('assets/images/prof_pic.png',
                                height: 100),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          const SizedBox(
            height: 20,
            width: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                view.isFetched ? view.userData.name : '',
                style: const TextStyle(
                    color: Helper.defaultTextColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          view.screenHeight > 520
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
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
                              CustomDrawerHeaderItem(
                                  isFetched: view.isFetched,
                                  title: view.userData.email,
                                  icon: Icons.email_outlined),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomDrawerHeaderItem(
                                  isFetched: view.isFetched,
                                  title: view.userData.phoneNumber,
                                  icon: CupertinoIcons.phone),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomDrawerHeaderItem(
                                  isFetched: view.isFetched,
                                  title: view.userData.nationality,
                                  icon: CupertinoIcons.location_solid),
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
    );
  }
}
