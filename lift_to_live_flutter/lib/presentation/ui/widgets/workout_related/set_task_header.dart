import 'package:flutter/material.dart';
import '../../../../helper.dart';

/// A header for a working set, part of a workout/template set entry.
class SetTaskHeader extends StatefulWidget {
  final bool isTemplate;

  const SetTaskHeader(
      {Key? key, required this.isTemplate})
      : super(key: key);

  @override
  State<SetTaskHeader> createState() => _SetTaskHeaderState();
}

class _SetTaskHeaderState extends State<SetTaskHeader> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
        decoration: const BoxDecoration(
          color: Helper.lightBlueColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
          //border: Border.all(color: Helper.whiteColor, width: 0.75),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //const SizedBox(),
              const Text('Kilograms', style: TextStyle(color: Helper.yellowColor, fontSize: 12),),
              const Text('Repetitions', style: TextStyle(color: Helper.yellowColor, fontSize: 12),),
              !widget.isTemplate ? const Text('Completed?', style: TextStyle(color: Helper.yellowColor, fontSize: 12),) : const SizedBox()
            ],
          ),
        ));
  }
}
