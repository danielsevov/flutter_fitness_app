import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/fixed_set_holder.dart';

import '../../../../helper.dart';

/// A holder for a single workout entry.
class WorkoutHolder extends StatefulWidget {
  final List<FixedSetHolder> workoutSetItems;
  final String name, note, created, completed, duration, totalVolume, userId;
  final int id;
  final Function(BuildContext context)? onEdit;

  const WorkoutHolder({
    Key? key,
    required this.workoutSetItems,
    required this.name,
    required this.note,
    required this.created,
    required this.completed,
    required this.duration, required this.totalVolume, required this.userId, required this.id, required this.onEdit,
  }) : super(key: key);

  @override
  State<WorkoutHolder> createState() => _WorkoutHolderState();
}

class _WorkoutHolderState extends State<WorkoutHolder> {
  bool isExpanded = false;

  /// Function used for setting the expansion state of the widget.
  void changeExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 20),
        margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
        decoration: BoxDecoration(
          color: Helper.lightBlueColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Helper.whiteColor.withOpacity(0.3), width: 0.75),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // name holder
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 50,),
            Text(widget.name, style: const TextStyle(color: Helper.yellowColor, fontSize: 22),),
            FloatingActionButton(heroTag: 'editWorkoutButton${widget.name}', onPressed: (){widget.onEdit!(context);}, isExtended: false, shape: const CircleBorder(),backgroundColor: Helper.whiteColor.withOpacity(0.33), mini: true, child: const Icon(Icons.edit_note_outlined),),],
        ),
            const SizedBox(
              height: 10,
            ),

            // note holder
            widget.note.isNotEmpty
                ? Row(
                    children: [
                      const SizedBox(width: 10,),
                      const Icon(
                        Icons.notes,
                        color: Helper.yellowColor,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 320,
                        child: Text(widget.note,
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Helper.textFieldTextColor)),
                      ),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(
              height: 10,
            ),

            // duration holder
            Row(
              children: [
                const SizedBox(width: 10,),
                const Icon(
                  CupertinoIcons.clock,
                  color: Helper.yellowColor,
                  size: 15,
                ),
                const SizedBox(
                  width: 10,
                ),
                widget.duration.isEmpty ? const Text('0 minutes', style: TextStyle(color: Helper.textFieldTextColor)) : Text('${(int.parse(widget.duration) / 360).round()} minutes',
                    style: const TextStyle(color: Helper.textFieldTextColor)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            // creation date holder
            Row(
              children: [
                const SizedBox(width: 10,),
                const Icon(
                  Icons.add_circle,
                  color: Helper.yellowColor,
                  size: 15,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                    Helper.formatter.format(DateTime.fromMicrosecondsSinceEpoch(
                        int.parse(widget.created) * 1000)),
                    style: const TextStyle(color: Helper.textFieldTextColor)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            // completion date holder
            Row(
              children: [
                const SizedBox(width: 10,),
                const Icon(
                  Icons.check_circle,
                  color: Helper.yellowColor,
                  size: 15,
                ),
                const SizedBox(
                  width: 10,
                ),
                widget.completed.isEmpty ? const Text('not completed', style: TextStyle(color: Helper.whiteColor),) : Text(
                    Helper.formatter.format(DateTime.fromMicrosecondsSinceEpoch(
                        int.parse(widget.completed) * 1000)),
                    style: const TextStyle(color: Helper.textFieldTextColor)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            // total workout volume holder
            Row(
              children: [
                const SizedBox(width: 10,),
                const Icon(
                  Icons.fitness_center_outlined,
                  color: Helper.yellowColor,
                  size: 15,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                    widget.totalVolume,
                    style: const TextStyle(color: Helper.textFieldTextColor)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            // Expansion control button
            FloatingActionButton.extended(heroTag: widget.name, elevation: 0, onPressed: changeExpansion, backgroundColor: Helper.lightBlueColor, icon: isExpanded ? const Icon(CupertinoIcons.chevron_up, color: Helper.yellowColor,) : const Icon(CupertinoIcons.chevron_down, color: Helper.yellowColor,), label: !isExpanded ? const Text('Show sets', style: TextStyle(color: Helper.yellowColor, fontSize: 15),) : const Text('Hide sets', style: TextStyle(color: Helper.yellowColor, fontSize: 15))),

            // sets holder
             isExpanded ? Column(
               children: widget.workoutSetItems,
             ) : const SizedBox(),
          ],
        ));
  }
}
