import 'package:flutter/material.dart';
import '../../../helper.dart';

class EditHabitHolder extends StatelessWidget {
  final TextEditingController newController;
  final List<Widget> bodyElements;
  final double screenWidth;
  final List<TextEditingController> controllers;
  final Function callback;

  const EditHabitHolder({super.key, required this.newController, required this.bodyElements, required this.screenWidth, required this.controllers, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Helper.lightBlueColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Helper.whiteColor, width: 2),

      ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    int index = controllers.indexOf(newController);
                    controllers.removeAt(index);
                    bodyElements.removeAt(index);
                    callback();
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Helper.yellowColor,
                  )),
              Expanded(
                child: TextField(
                  controller: newController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Enter new habit",
                    hintStyle:
                    TextStyle(color: Colors.white54, fontSize: 20, height: 0.8),
                  ),
                  style:
                  const TextStyle(color: Colors.white, fontSize: 20, height: 0.8),
                ),)
            ]),
      ),
    );
  }
}
