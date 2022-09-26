import 'dart:convert';

import 'package:first_solo_flutter_app/main.dart';
import 'package:first_solo_flutter_app/models/habit.dart';
import 'package:first_solo_flutter_app/pages/edit_habit_route.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Helper.dart';

class HabitsRoute extends StatelessWidget {
  HabitsRoute({super.key, required this.userId});

  //page owner userId
  final String userId;

  //list of habit instances
  final habitsWidgets = <Widget>[];
  static Habit? template;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        actions: [
          //button for editing the habits template
          IconButton(onPressed: () async {
            Helper.pushPage(context, EditHabitRoute(userId: userId,));
          }, icon: const Icon(
            Icons.edit_note,
            size: 35,
            color: Colors.white,
          )),
          const SizedBox(width: 20,)
        ],
        title: const Text(
          "Habits",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Helper.blueColor,
      ),
      body: FutureBuilder(
        builder: (ctx, response) {
          //check if connection is complete
          if (response.connectionState == ConnectionState.done) {
            //if data is present
            if (response.hasData) {
              final data = response.data as http.Response;

              //decode all habits
              List<dynamic> list = json.decode(data.body);
              final allHabits = <Habit>[];

              //transform them to Habit instances
              for (var element in list) {
                allHabits.add(Habit.fromJson(element));
              }

              //filter only habits for current user
              final filteredHabits = allHabits
                  .where((element) =>
                      element.userId == userId && !element.isTemplate)
                  .toList();

              //sort by date
              filteredHabits.sort((a, b) => b.date.compareTo(a.date));

              //create todays habit if not present
              if (filteredHabits.isEmpty ||
                  DateTime.fromMicrosecondsSinceEpoch(
                          int.parse(filteredHabits.first.date) * 1000)
                      .isBefore(DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day))) {
                Helper.postHabit(
                    context,
                    filteredHabits,
                    MyApp.jwtToken,
                    (DateTime.now().millisecondsSinceEpoch).toString(),
                    HabitsRoute.template!.note,
                    HabitsRoute.template!.userId,
                    HabitsRoute.template!.coachId,
                    HabitsRoute.template!.habits,
                    (http.Response res) async => {
                    allHabits.add(Habit.fromJson(jsonDecode(res.body))),
                    await Future.delayed(const Duration(seconds: 1)),
                    Helper.replacePage(context, HabitsRoute(userId: userId))
                    });
              }

              final DateFormat formatter = DateFormat('dd/MM/yyyy');

              //add calendar on top of all widgets
              habitsWidgets.add(Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                child: TableCalendar(
                    calendarStyle: const CalendarStyle(
                        weekendTextStyle: TextStyle(color: Helper.blueColor),
                        todayDecoration: BoxDecoration(
                            shape: BoxShape.rectangle, color: Helper.blueColor),
                        todayTextStyle: TextStyle(color: Colors.white),
                        disabledTextStyle: TextStyle(color: Colors.grey),
                        outsideTextStyle: TextStyle(color: Helper.blueColor),
                        defaultTextStyle: TextStyle(color: Helper.blueColor)),

                    //manage style of selected cells
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        //green cells
                        for (DateTime d in filteredHabits
                            .where((element) => element.habits
                                .every((element) => element.isCompleted))
                            .map((e) => DateTime.fromMicrosecondsSinceEpoch(
                                int.parse(e.date) * 1000))) {
                          if (day.day == d.day &&
                              day.month == d.month &&
                              day.year == d.year) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.green,
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
                        for (DateTime d in filteredHabits
                            .where((element) =>
                                element.habits
                                    .any((element) => element.isCompleted) &&
                                element.habits
                                    .any((element) => !element.isCompleted))
                            .map((e) => DateTime.fromMicrosecondsSinceEpoch(
                                int.parse(e.date) * 1000))) {
                          if (day.day == d.day &&
                              day.month == d.month &&
                              day.year == d.year) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.yellow,
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

                        //red cells
                        for (DateTime d in filteredHabits
                            .where((element) => element.habits
                                .every((element) => !element.isCompleted))
                            .map((e) => DateTime.fromMicrosecondsSinceEpoch(
                                int.parse(e.date) * 1000))) {
                          if (day.day == d.day &&
                              day.month == d.month &&
                              day.year == d.year) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
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
                        return null;
                      },
                    ),
                    focusedDay: DateTime.now(),
                    firstDay: DateTime.utc(2022),
                    lastDay: DateTime.now()),
              ));

              //add list of habitTasks widgets (1 for each habit task in a habit instance)
              for (Habit element in filteredHabits) {
                final habitTaskWidgets = <Widget>[];
                Habit habit = element;
                for (var element in habit.habits) {
                  habitTaskWidgets.add(Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Helper.blueColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            element.task,
                            style: const TextStyle(
                                color: Helper.blueColor,
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
                                        color: Helper.blueColor, width: 2),
                                    checkColor: Colors.white,
                                    fillColor:
                                        MaterialStateProperty.all(Helper.blueColor),
                                    value: element.isCompleted,
                                    onChanged:
                                        DateTime.fromMicrosecondsSinceEpoch(
                                                    int.parse(habit.date) *
                                                        1000)
                                                .isBefore(DateTime(
                                                    DateTime.now().year,
                                                    DateTime.now().month,
                                                    DateTime.now().day))
                                            ? null
                                            : (value) {
                                                setState(() => element
                                                    .isCompleted = value!);
                                                print("id ${habit.id}");
                                                Helper.patchHabit(
                                                    MyApp.jwtToken,
                                                    habit.id,
                                                    habit.date,
                                                    habit.note,
                                                    habit.userId,
                                                    habit.coachId,
                                                    habit.habits);
                                              },
                                  ))
                        ],
                      )));
                }

                //add habit tasks to the habit instance widget
                habitsWidgets.add(Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  decoration: BoxDecoration(
                    color: Helper.blueColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Helper.blueColor),
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
                                  formatter.format(
                                      DateTime.fromMicrosecondsSinceEpoch(
                                          int.parse(habit.date) * 1000)),
                                  style: const TextStyle(
                                      color: Helper.blueColor,
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
                ));
              }

              habitsWidgets.add(const SizedBox(
                height: 10,
              ));

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: habitsWidgets,
                ),
              );
            }
          }

          // Displaying LoadingSpinner to indicate waiting state
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: Helper.fetchHabits(MyApp.jwtToken, userId, (http.Response res) =>{
          HabitsRoute.template = Habit.fromJson(jsonDecode(res.body)[0])}),
      ),
    );
  }
}