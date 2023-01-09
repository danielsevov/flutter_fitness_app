import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/factory/page_factory.dart';
import 'package:lift_to_live_flutter/presentation/presenters/workout_templates_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/fixed_set_holder.dart';

import '../../../../helper.dart';
import '../reusable_elements/custom_dialog.dart';

/// A holder for a single template workout entry.
class TemplateWorkoutHolder extends StatefulWidget {
  final List<FixedSetHolder> workoutSetItems;
  final String name, note, creationDate, userId;
  final int id;
  final WorkoutTemplatesPagePresenter presenter;

  const TemplateWorkoutHolder(
      {Key? key, required this.workoutSetItems, required this.name, required this.note, required this.creationDate, required this.id, required this.userId, required this.presenter, })
      : super(key: key);

  @override
  State<TemplateWorkoutHolder> createState() => _TemplateWorkoutHolderState();
}

class _TemplateWorkoutHolderState extends State<TemplateWorkoutHolder> {
  bool isExpanded = false;

  void changeExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
        margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
        decoration: BoxDecoration(
          color: Helper.lightBlueColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Helper.whiteColor.withOpacity(0.3), width: 0.75),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 50,),
                Text(widget.name, style: const TextStyle(color: Helper.yellowColor, fontSize: 22),),
                FloatingActionButton(heroTag: 'editWorkoutButton${widget.name}', onPressed: (){
                  Helper.replacePage(context, PageFactory().getWorkoutPage(widget.id, widget.userId, true, true));
                }, isExtended: false, shape: const CircleBorder(),backgroundColor: Helper.whiteColor.withOpacity(0.33), mini: true, child: const Icon(Icons.edit_note_outlined),),],
            ),
            const SizedBox(height: 10,),
            Text('Note: ${widget.note}', style: const TextStyle(color: Helper.textFieldTextColor),),
            const SizedBox(height: 10,),
            Text('Created on ${Helper.formatter.format(
                DateTime.fromMicrosecondsSinceEpoch(
                    int.parse(widget.creationDate) * 1000))}', style: const TextStyle(color: Helper.textFieldTextColor),),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FloatingActionButton.extended(heroTag: widget.name, elevation: 0, onPressed: changeExpansion, backgroundColor: Helper.lightBlueColor, icon: isExpanded ? const Icon(CupertinoIcons.chevron_up, color: Helper.yellowColor,) : const Icon(CupertinoIcons.chevron_down, color: Helper.yellowColor,), label: !isExpanded ? const Text('Show sets', style: TextStyle(color: Helper.yellowColor, fontSize: 15),) : const Text('Hide sets', style: TextStyle(color: Helper.yellowColor, fontSize: 15))),
              ],
            ),
            isExpanded ? SizedBox(
              child: Column(
                children: widget.workoutSetItems,
              ),
            ) : const SizedBox(),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton.extended(heroTag: 'startWorkoutButton${widget.name}', onPressed: (){
                  Helper.replacePage(context, PageFactory().getWorkoutPage(widget.id, widget.userId, false, true));
                }, isExtended: true, label: const Text('Start Workout', style: TextStyle(color: Helper.blackColor, fontWeight: FontWeight.w800),), icon: const Icon(Icons.fitness_center_outlined, color: Helper.blackColor,), backgroundColor: Helper.yellowColor,),
                FloatingActionButton.extended(heroTag: 'copyTemplateButton${widget.name}', onPressed: (){
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                            title: 'Duplicate Template',
                            bodyText: 'Are you sure you want to make a copy of this template?',
                            confirm: () {
                              widget.presenter.copyWorkout(widget.id);
                            },
                            cancel: () {
                              Navigator.pop(context);
                            });
                      });
                }, isExtended: true, label: const Text('Copy', style: TextStyle(color: Helper.whiteColor),), backgroundColor: Helper.redColor, icon: const Icon(Icons.copy, color: Helper.whiteColor,),),
              ],
            )
          ],
        ));
  }
}
