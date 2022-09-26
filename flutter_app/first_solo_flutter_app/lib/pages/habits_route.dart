import 'dart:convert';

import 'package:first_solo_flutter_app/models/habit.dart';
import 'package:first_solo_flutter_app/pages/edit_habits_route.dart';
import 'package:first_solo_flutter_app/widgets/habit_task_holder.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

import '../api_services.dart';
import '../helper.dart';
import '../widgets/habit_holder.dart';

class HabitsRoute extends StatefulWidget {
  const HabitsRoute({super.key, required this.userId});

  //page owner userId
  final String userId;

  @override
  State<HabitsRoute> createState() => _HabitsRouteState();
}

class _HabitsRouteState extends State<HabitsRoute> {
  //list of habit instances
  final habitsWidgets = <Widget>[], calendarWidgets = <Widget>[];
  Habit? template;

  late final List<Habit> filteredHabits;
  late double screenHeight, screenWidth;
  late Future<void> future;

  @override
  void initState() {
    future = initializeHabits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //get screen size values
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    template = null;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/whitewaves.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: FutureBuilder(
            builder: (ctx, response) {
              //check if connection is complete
              if (response.connectionState == ConnectionState.done) {
                return CustomScrollView(slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Helper.redColor,
                    pinned: true,
                    snap: true,
                    floating: true,
                    expandedHeight: 100.0,
                    shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    flexibleSpace: const FlexibleSpaceBar(
                      title: Text('My Habits', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w300),),
                      centerTitle: true,
                    ),
                    actions: [
                      IconButton(
                          onPressed: () async {
                            if (APIServices.myRoles.any((element) =>
                            element.name == "coach" || element.name == "admin")) {
                              Helper.replacePage(
                                  context,
                                  EditHabitsRoute(
                                    userId: widget.userId,
                                  ));
                            } else {
                              Helper.makeToast(
                                  context, "You don't have the permission to edit habits!");
                            }
                          },
                          icon: const Icon(
                            Icons.edit_note,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return addCalendarWidget(calendarWidgets, filteredHabits);
                      },
                      childCount: 1,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return Container(color: index.isOdd ? Colors.white : Helper.blueColor.withOpacity(0.12),
                          padding: const EdgeInsets.all(10), child: habitsWidgets[index],);
                      },
                      childCount: habitsWidgets.length,
                    ),
                  )
                ]);
              }

              // Displaying LoadingSpinner to indicate waiting state
              return const Center(
                child: CircularProgressIndicator(
                  color: Helper.redColor,
                ),
              );
            },
            future: future),
      ),
    );
  }

  Widget addCalendarWidget(
      List<Widget> calendarWidgets, List<Habit> filteredHabits) {
    //add calendar on top of all widgets
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: TableCalendar(
          calendarStyle: const CalendarStyle(
              weekendTextStyle: TextStyle(color: Helper.redColor),
              todayDecoration: BoxDecoration(
                  shape: BoxShape.rectangle, color: Helper.redColor),
              todayTextStyle: TextStyle(color: Colors.white),
              disabledTextStyle: TextStyle(color: Colors.grey),
              outsideTextStyle: TextStyle(color: Helper.redColor),
              defaultTextStyle: TextStyle(color: Helper.redColor)),
          headerStyle: const HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
          ),

          //manage style of selected cells
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              //green cells
              for (DateTime d in filteredHabits
                  .where((element) =>
                      element.habits.every((element) => element.isCompleted))
                  .map((e) => DateTime.fromMicrosecondsSinceEpoch(
                      int.parse(e.date) * 1000))) {
                if (day.day == d.day &&
                    day.month == d.month &&
                    day.year == d.year) {
                  return Container(
                    width: 40,
                    height: 40,
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
                      element.habits.any((element) => element.isCompleted) &&
                      element.habits.any((element) => !element.isCompleted))
                  .map((e) => DateTime.fromMicrosecondsSinceEpoch(
                      int.parse(e.date) * 1000))) {
                if (day.day == d.day &&
                    day.month == d.month &&
                    day.year == d.year) {
                  return Container(
                    width: 40,
                    height: 40,
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
              return Container(
                width: 40,
                height: 40,
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
            },
          ),
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2022),
          lastDay: DateTime.now()),
    );
  }

  Future<void> initializeHabits() async {
    var response = await APIServices.fetchHabits(
        widget.userId,
        (http.Response res) => {
              if (res.body.length > 2)
                {template = Habit.fromJson(jsonDecode(res.body)[0])}
            });

    //decode all habits
    List<dynamic> list = json.decode(response.body);
    final allHabits = <Habit>[];

    //transform them to Habit instances
    for (var element in list) {
      allHabits.add(Habit.fromJson(element));
    }

    //filter only habits for current user
    filteredHabits = allHabits
        .where(
            (element) => element.userId == widget.userId && !element.isTemplate)
        .toList();

    //sort by date
    filteredHabits.sort((a, b) => b.date.compareTo(a.date));

    //create today's habit if not present
    if (mounted &&
        template != null &&
        (filteredHabits.isEmpty ||
            DateTime.fromMicrosecondsSinceEpoch(
                    int.parse(filteredHabits.first.date) * 1000)
                .isBefore(DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day)))) {
      APIServices.postHabit(
          context,
          (DateTime.now().millisecondsSinceEpoch).toString(),
          template!.note,
          template!.userId,
          template!.coachId,
          false,
          template!.habits,
          (http.Response res) async => {
                allHabits.add(Habit.fromJson(jsonDecode(res.body))),
                await Future.delayed(const Duration(seconds: 1)),
                Helper.replacePage(context, HabitsRoute(userId: widget.userId))
              });
    }

    //add list of habitTasks widgets (1 for each habit task in a habit instance)
    for (Habit element in filteredHabits) {
      final habitTaskWidgets = <Widget>[];
      Habit habit = element;
      for (var element in habit.habits) {
        habitTaskWidgets.add(HabitTaskHolder(
            element: element, habit: habit, userId: widget.userId));
      }

      //add habit tasks to the habit instance widget
      habitsWidgets
          .add(HabitHolder(habit: habit, habitTaskWidgets: habitTaskWidgets));
    }

    habitsWidgets.add(const SizedBox(
      height: 10,
    ));
  }
}
