import 'dart:convert';

import 'package:first_solo_flutter_app/main.dart';
import 'package:first_solo_flutter_app/models/habit_task.dart';
import 'package:first_solo_flutter_app/pages/habits_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:first_solo_flutter_app/Helper.dart';

import '../models/habit.dart';

class EditHabitRoute extends StatefulWidget {
  const EditHabitRoute({Key? key, required this.userId}) : super(key: key);

  //userId for the current user (page owner)
  final String userId;

  @override
  _EditHabitRouteState createState() => _EditHabitRouteState(userId);
}

//lists of widgets and text controllers for managing listview
List<Widget> bodyElements = [];
int num = 0;
List<TextEditingController> controllers = [];

//template habits instance
Habit? template;

//function for adding new task
void addBodyElement(String name, Function() callback) {
  TextEditingController newController = TextEditingController();
  bodyElements.add(
    Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Helper.blueColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              //on pressed clear token and navigate to log in page
                onPressed: () {
                    int index = controllers.indexOf(newController);
                    controllers.removeAt(index);
                    bodyElements.removeAt(index);
                    num--;
                    callback();
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                )),
            SizedBox(
            width: 250,
            child: TextField(
            controller: newController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: "Enter new habit",
              hintStyle:
              TextStyle(color: Colors.white54, fontSize: 20, height: 0.8),
            ),
            style:
            const TextStyle(color: Colors.white, fontSize: 20, height: 0.8),
          ),)
        ]),
      ),
    ),
  );
  newController.text = name;
  controllers.add(newController);
}

class _EditHabitRouteState extends State<EditHabitRoute> {
  final String userId;

  _EditHabitRouteState(this.userId);

  void refresh(){
    setState(() {

    });
  }

  //initialize page
  @override
  void initState() {
    controllers.clear();
    bodyElements.clear();
    num = 0;

    Helper.fetchTemplate(
        MyApp.jwtToken,
        userId,
        (http.Response res) =>
            {template = Habit.fromJson(jsonDecode(res.body)[0])});

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        for (var element in template!.habits) {
          addBodyElement(element.task, refresh);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              setState(() {
                bodyElements.clear();
                controllers.clear();
                num = 0;
              });
            },
          )
        ],
        backgroundColor: Helper.blueColor,
        title: const Text(
          "Edit habit template",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: bodyElements,
          ),
        ],
      ),
      //wrap multiple buttons in the same wrap for them to appear side by side
      floatingActionButton: Wrap(
        //will break to another line on overflow
        direction: Axis.horizontal, //use vertical to show  on vertical axis
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(10),
              child: FloatingActionButton.extended(
                heroTag: "btn1",
                icon: const Icon(Icons.add),
                label: const Text('Add'),
                onPressed: () {
                  num++;
                  setState(() {
                    addBodyElement("", refresh);
                  });
                },
              )), // button third

          Container(
              margin: EdgeInsets.all(10),
              child: FloatingActionButton.extended(
                heroTag: "btn2",
                backgroundColor: Colors.green,
                icon: const Icon(
                  Icons.save,
                ),
                label: const Text('Save Changes'),
                onPressed: () {
                  List<HabitTask> newTasks = [];
                  controllers.map((e) => e.text.toString()).forEach((element) {
                    newTasks.add(HabitTask(element, false));
                  });
                  Helper.patchHabit(
                      MyApp.jwtToken,
                      template!.id,
                      (DateTime.now().millisecondsSinceEpoch).toString(),
                      template!.note,
                      userId,
                      MyApp.userId,
                      newTasks);

                  Helper.makeToast(context, "Habits saved!");
                },
              )),
        ],
      ),
    );
  }
}
