import 'package:flutter/material.dart';

import '../../../../helper.dart';

/// Custom widget used for viewing a picture in fullscreen.
class DetailScreen extends StatelessWidget {
  final Image img;

  const DetailScreen({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
          color: Helper.paragraphBackgroundColor.withOpacity(0.3),
          width: double.infinity,
          height: double.infinity,
          child: FittedBox(
            fit: BoxFit.contain,
            child: img,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}