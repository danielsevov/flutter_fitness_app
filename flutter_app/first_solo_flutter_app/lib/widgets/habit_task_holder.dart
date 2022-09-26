import 'dart:developer';

import 'package:first_solo_flutter_app/models/habit.dart';
import 'package:first_solo_flutter_app/models/habit_task.dart';
import 'package:flutter/material.dart';

import '../api_services.dart';
import '../helper.dart';

class HabitTaskHolder extends StatelessWidget {
  const HabitTaskHolder({Key? key, required this.habit, required this.element, required this.userId}) : super(key: key);

  final Habit habit;
  final HabitTask element;
  final String userId;


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Helper.redColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              element.task,
              style: const TextStyle(
                  color: Helper.redColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 20,
              width: 10,
            ),
            StatefulBuilder(
                builder: (ctx, setState) => Checkbox(
                  side: const BorderSide(
                      color: Helper.redColor, width: 2),
                  checkColor: Colors.white,
                  fillColor:
                  MaterialStateProperty.all(DateTime.fromMicrosecondsSinceEpoch(
                      int.parse(habit.date) *
                          1000)
                      .isBefore(DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day)) || APIServices.userId != userId
                      ? Helper.redColor.withOpacity(0.3)
                      : Helper.redColor.withOpacity(1)),
                  value: element.isCompleted,
                  onChanged:
                  DateTime.fromMicrosecondsSinceEpoch(
                      int.parse(habit.date) *
                          1000)
                      .isBefore(DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day)) || APIServices.userId != userId
                      ? null
                      : (value) {
                    setState(() => element
                        .isCompleted = value!);
                    log("id ${habit.id}");
                    APIServices.patchHabit(
                        habit.id,
                        habit.date,
                        habit.note,
                        habit.userId,
                        habit.coachId,
                        habit.habits);
                  },
                ))
          ],
        ));
  }
}
