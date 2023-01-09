import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/reusable_elements/custom_dropdown_text_field.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/set_task_header.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/set_task_holder.dart';

import '../../../../helper.dart';

/// A holder for a single non editable (fixed) set, part of a workout/template entry.
class FixedSetHolder extends StatefulWidget {
  final List<SetTaskHolder> setTasks;

  final TextEditingController noteController;
  final SingleValueDropDownController exerciseController;

  final bool isTemplate;
  final List<String> exercises;
  final int setIndex;

  const FixedSetHolder(
      {Key? key,
      required this.setTasks,
      required this.exerciseController,
      required this.noteController,
      required this.exercises,
      required this.setIndex,
      required this.isTemplate})
      : super(key: key);

  @override
  State<FixedSetHolder> createState() => _FixedSetHolderState();
}

class _FixedSetHolderState extends State<FixedSetHolder> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Helper.blueColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Helper.whiteColor.withOpacity(0.3), width: 0.75),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // set label holder
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Set #${widget.setIndex}',
                  style: const TextStyle(color: Helper.yellowColor),
                ),
              ],
            ),

            // exercise holder
            CustomDropdownTextField(
                controller: widget.exerciseController,
                textInputType: TextInputType.text,
                hint: 'Enter exercise',
                icon: Icons.fitness_center_outlined,
                obscureText: false,
                items: widget.exercises,
                isEnabled: false),
            const SizedBox(
              height: 10,
            ),

            // note holder
            widget.noteController.text.isEmpty
                ? const SizedBox()
                : TextField(
                    style: const TextStyle(
                      color: Helper.textFieldTextColor,
                    ),
                    maxLines: 10,
                    minLines: 1,
                    decoration: const InputDecoration(
                      hintText: 'Enter note',
                      hintStyle: TextStyle(color: Helper.hintGreyColor),
                      icon: Icon(
                        Icons.notes,
                        color: Helper.yellowColor,
                      ),
                    ),
                    controller: widget.noteController,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    enabled: false,
                  ),
            const SizedBox(
              height: 10,
            ),

            // set header
            SetTaskHeader(isTemplate: widget.isTemplate),

            // set tasks holder
            SizedBox(
              // height: 200,
              // width: 400,
              child: Column(
                children: widget.setTasks,
              ),
            )
          ],
        ));
  }
}
