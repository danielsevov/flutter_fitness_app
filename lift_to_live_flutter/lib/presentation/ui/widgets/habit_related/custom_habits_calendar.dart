import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../domain/entities/habit.dart';
import '../../../../helper.dart';

/// Custom calendar widget for overviewing habit entries.
/// Placed on the habits page view.
class CustomHabitsCalendar extends StatelessWidget {
  final List<Habit> habits;

  const CustomHabitsCalendar({super.key, required this.habits});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: habits.isNotEmpty
          ? TableCalendar(
              calendarStyle: const CalendarStyle(
                  weekendTextStyle: TextStyle(color: Helper.whiteColor),
                  todayDecoration: BoxDecoration(
                      shape: BoxShape.rectangle, color: Helper.yellowColor),
                  todayTextStyle: TextStyle(color: Helper.blackColor),
                  disabledTextStyle: TextStyle(color: Colors.grey),
                  outsideTextStyle: TextStyle(color: Helper.yellowColor),
                  defaultTextStyle: TextStyle(color: Helper.yellowColor)),
              headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(color: Helper.whiteColor),
                formatButtonTextStyle: TextStyle(color: Helper.yellowColor),
                leftChevronIcon: Icon(
                  Icons.arrow_circle_left,
                  color: Helper.yellowColor,
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_circle_right,
                  color: Helper.yellowColor,
                ),
                titleCentered: true,
                formatButtonVisible: false,
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Helper.whiteColor),
                  weekendStyle: TextStyle(color: Colors.grey)),

              //manage style of selected cells
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  //green cells
                  for (DateTime d in habits
                      .where((element) => element.habits
                          .every((element) => element.isCompleted))
                      .map((e) => DateTime.fromMicrosecondsSinceEpoch(
                          int.parse(e.date) * 1000))) {
                    if (day.day == d.day &&
                        day.month == d.month &&
                        day.year == d.year) {
                      return Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.green.shade800,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }
                  }

                  //yellow cells
                  for (DateTime d in habits
                      .where((element) =>
                          element.habits
                              .any((element) => element.isCompleted) &&
                          element.habits.any((element) => !element.isCompleted))
                      .map((e) => DateTime.fromMicrosecondsSinceEpoch(
                          int.parse(e.date) * 1000))) {
                    if (day.day == d.day &&
                        day.month == d.month &&
                        day.year == d.year) {
                      return Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade800,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    }
                  }
                  return Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.red.shade800,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2022),
              lastDay: DateTime.now())
          : const SizedBox(),
    );
  }
}
