import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/domain/entities/workout_set.dart';
import 'package:lift_to_live_flutter/presentation/presenters/workout_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/reusable_elements/custom_dropdown_text_field.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/set_task_header.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/set_task_holder.dart';

import '../../../../helper.dart';

/// A holder for a single editable set, part of a workout/template entry.
class EditableSetHolder extends StatefulWidget {
  final List<SetTaskHolder> setTasks;
  final WorkoutPagePresenter presenter;

  final TextEditingController noteController;
  final SingleValueDropDownController exerciseController;
  final List<TextEditingController> repsControllers,
      kilosControllers,
      isCompletedControllers;

  final bool isEnabled, isTemplate;
  final List<String> exercises;

  final String tag;

  const EditableSetHolder(
      {Key? key,
      required this.setTasks,
      required this.exerciseController,
      required this.noteController,
      required this.isEnabled,
      required this.exercises,
      required this.presenter,
      required this.repsControllers,
      required this.kilosControllers,
      required this.isCompletedControllers, required this.tag, required this.isTemplate})
      : super(key: key);

  @override
  State<EditableSetHolder> createState() => EditableSetHolderState();

  WorkoutSet toWorkoutSet() {
    String setNote, exercise;
    List<int> reps = [], kilos = [];

    if( exerciseController.dropDownValue?.name == null ) return WorkoutSet('', [], [], '', false);

    setNote = noteController.text;
    exercise = exerciseController.dropDownValue!.name;

    bool isComplete = true;
    for (int i = 0; i < repsControllers.length; i++) {
      if(repsControllers[i].text.isEmpty || kilosControllers[i].text.isEmpty) continue;

      reps.add(int.parse(repsControllers[i].text));
      kilos.add(int.parse(kilosControllers[i].text));
      if(isCompletedControllers[i].text == 'false') isComplete = false;
    }

    if( reps.isEmpty || kilos.isEmpty ) return WorkoutSet('', [], [], '', false);

    return WorkoutSet(setNote, reps, kilos, exercise, isComplete);
  }
}

class EditableSetHolderState extends State<EditableSetHolder>  with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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

            // exercise holder
            CustomDropdownTextField(
                controller: widget.exerciseController,
                textInputType: TextInputType.text,
                hint: 'Select exercise',
                icon: Icons.fitness_center_outlined,
                obscureText: false,
                onChanged: (newString) {
                  if (newString != null && newString.toString().isNotEmpty) {
                    setState(() {
                      widget.exerciseController.dropDownValue = newString;
                    });
                  }
                },
                items: widget.exercises,
                isEnabled: widget.isEnabled),
            const SizedBox(
              height: 10,
            ),

            // note holder
            TextField(
              style: const TextStyle(
                color: Helper.textFieldTextColor,
              ),
              maxLines: 10,
              minLines: 1,
              decoration: const InputDecoration(
                hintText: 'Enter note',
                hintStyle: TextStyle(color: Helper.textFieldHintColor),
                icon: Icon(
                  Icons.notes,
                  color: Helper.whiteColor,
                ),
              ),
              controller: widget.noteController,
              keyboardType: TextInputType.multiline,
              obscureText: false,
              enabled: widget.isEnabled,
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
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FloatingActionButton.extended(
                backgroundColor: Helper.yellowColor,
                onPressed: () {
                  addNewTask();
                },
                icon: const Icon(
                  Icons.add,
                  color: Helper.blackColor,
                ),
                heroTag: widget.tag,
                label: const Text(
                  'Add Set',
                  style: TextStyle(color: Helper.blackColor),
                ),
              ),
            )
          ],
        ));
  }

  /// Function used for adding a new set task to this set holder.
  void addNewTask() {
    TextEditingController repsController = TextEditingController(),
        kilosController = TextEditingController(),
        isCompletedController = TextEditingController();

    widget.repsControllers.add(repsController);
    widget.kilosControllers.add(kilosController);
    widget.isCompletedControllers.add(isCompletedController);

    setState(() {
      widget.setTasks.add(SetTaskHolder(
        repsController: repsController,
        kilosController: kilosController,
        isCompletedController: isCompletedController,
        isEnabled: true,
        isTemplate: widget.isTemplate,
      ));
    });
  }
}
