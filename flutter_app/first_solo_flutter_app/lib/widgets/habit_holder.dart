import 'package:first_solo_flutter_app/models/habit.dart';
import 'package:flutter/material.dart';

import '../helper.dart';

class HabitHolder extends StatelessWidget {
  final Habit habit;
  final List<Widget> habitTaskWidgets;

  const HabitHolder({super.key, required this.habit, required this.habitTaskWidgets});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      decoration: BoxDecoration(
        color: Helper.redColor,
        borderRadius: const BorderRadius.only(topRight: Radius.circular(90), topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        border: Border.all(color: Helper.redColor),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Text(
                      Helper.formatter.format(
                          DateTime.fromMicrosecondsSinceEpoch(
                              int.parse(habit.date) * 1000)),
                      style: const TextStyle(
                          color: Helper.redColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 24),
                    ),
                    const SizedBox(
                      width: 20,
                      height: 30,
                    ),
                    Icon(
                        !habit.habits.any(
                                (element) => !element.isCompleted)
                            ? Icons.thumb_up
                            : habit.habits.any((element) =>
                        !element.isCompleted) &&
                            habit.habits.any((element) =>
                            element.isCompleted)
                            ? Icons.thumbs_up_down
                            : Icons.thumb_down,
                        size: 50,
                        color: !habit.habits.any(
                                (element) => !element.isCompleted)
                            ? Colors.green
                            : habit.habits.any((element) =>
                        !element.isCompleted) &&
                            habit.habits.any((element) =>
                            element.isCompleted)
                            ? Colors.yellow
                            : Colors.red)
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const SizedBox(height: 10),
              Text(
                habit.note.isEmpty
                    ? ''
                    : 'Coach note: ${habit.note}',
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: habitTaskWidgets,
          )
        ],
      ),
    );
  }
}
