import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/domain/entities/exercise.dart';
import '../../../../helper.dart';

/// A holder for the information related to an exercise, used for helping the user while doing the workout.
class ExerciseInfoHolder extends StatefulWidget {
  final Exercise exercise;

  const ExerciseInfoHolder({super.key, required this.exercise});

  @override
  State<ExerciseInfoHolder> createState() => _ExerciseInfoHolderState();
}

class _ExerciseInfoHolderState extends State<ExerciseInfoHolder> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Helper.whiteColor.withOpacity(0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        decoration: const BoxDecoration(
          color: Helper.lightBlueColor,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          //border: Border.all(color: Helper.whiteColor, width: 0.75),
        ),
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 50,),
                  SizedBox(child: Text(widget.exercise.name.toUpperCase(), style: const TextStyle(color: Helper.yellowColor, fontSize: 12))),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: IconButton(onPressed: (){
                      setState(() {
                        Navigator.pop(context);
                      });
                    }, icon: const Icon(Icons.cancel, color: Helper.yellowColor,),),
                  )

            ]),
            SizedBox(child: Text("Body Part: ${widget.exercise.bodyPart.toUpperCase()}", style: const TextStyle(color: Helper.yellowColor, fontSize: 12),)),
            SizedBox(child: Text("Muscle Group: ${widget.exercise.muscleGroup.toUpperCase()}", style: const TextStyle(color: Helper.yellowColor, fontSize: 12),)),
            SizedBox(child: Text("Equipment: ${widget.exercise.equipment.toUpperCase()}", style: const TextStyle(color: Helper.yellowColor, fontSize: 12),)),
            SizedBox(width: 200, height: 200,child: ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(10)),child: Image.network(widget.exercise.gifUrl),)),
          ],
        ),
      ),
    );
  }
}
