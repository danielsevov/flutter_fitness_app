import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../helper.dart';

/// Custom calendar widget for overviewing workout entries.
/// Placed on the workouts page view.
class CustomWorkoutCalendar extends StatelessWidget {
  final List<String> workoutDates;

  const CustomWorkoutCalendar({super.key, required this.workoutDates});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: workoutDates.isNotEmpty
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
                  for (DateTime d in workoutDates
                      .map((e) => DateTime.fromMicrosecondsSinceEpoch(
                          int.parse(e) * 1000))) {
                    if (day.day == d.day &&
                        day.month == d.month &&
                        day.year == d.year) {
                      return Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Helper.yellowColor,
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
                  return Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: null,
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
