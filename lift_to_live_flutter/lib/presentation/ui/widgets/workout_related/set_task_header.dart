import 'package:flutter/material.dart';
import '../../../../helper.dart';

/// A header for a working set, part of a workout/template set entry.
class SetTaskHeader extends StatefulWidget {
  final bool isTemplate;

  const SetTaskHeader({super.key, required this.isTemplate});

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
              const SizedBox(width: 70,child: Text('Kilograms', style: TextStyle(color: Helper.yellowColor, fontSize: 12),)),
              const SizedBox(width: 70,child: Text('Repetitions', style: TextStyle(color: Helper.yellowColor, fontSize: 12),)),
              !widget.isTemplate ? const SizedBox(width: 70,child: Text('Completed?', style: TextStyle(color: Helper.yellowColor, fontSize: 12),)) : const SizedBox()
            ],
          ),
        ));
  }
}
