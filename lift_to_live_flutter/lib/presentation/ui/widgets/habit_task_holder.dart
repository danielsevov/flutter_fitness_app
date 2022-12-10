import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/presentation/presenters/habits_page_presenter.dart';

import '../../../domain/entities/habit.dart';
import '../../../domain/entities/habit_task.dart';
import '../../../helper.dart';


class HabitTaskHolder extends StatelessWidget {
  const HabitTaskHolder({Key? key, required this.habit, required this.habitTask, required this.userId, required this.currentUserId, required this.presenter}) : super(key: key);

  final Habit habit;
  final HabitTask habitTask;
  final String userId, currentUserId;
  final HabitsPagePresenter presenter;


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Helper.blueColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Helper.whiteColor, width: 0.75),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              habitTask.task,
              style: const TextStyle(
                  color: Helper.whiteColor,
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
                      color: Helper.yellowColor, width: 2),
                  checkColor: Helper.blackColor,
                  fillColor:
                  MaterialStateProperty.all(DateTime.fromMicrosecondsSinceEpoch(
                      int.parse(habit.date) *
                          1000)
                      .isBefore(DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day)) || currentUserId != userId
                      ? Helper.yellowColor.withOpacity(0.3)
                      : Helper.yellowColor.withOpacity(1)),
                  value: habitTask.isCompleted,
                  onChanged:
                  DateTime.fromMicrosecondsSinceEpoch(
                      int.parse(habit.date) *
                          1000)
                      .isBefore(DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day)) || currentUserId != userId
                      ? null
                      : (value) {
                    setState(() => habitTask
                        .isCompleted = value!);
                    log("id ${habit.id}");
                    presenter.updateHabitEntry(
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
