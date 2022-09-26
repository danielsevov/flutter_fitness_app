import 'dart:convert';

import 'package:first_solo_flutter_app/api_services.dart';
import 'package:first_solo_flutter_app/models/habit_task.dart';
import 'package:first_solo_flutter_app/pages/habits_route.dart';
import 'package:first_solo_flutter_app/widgets/edit_habit_holder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:first_solo_flutter_app/helper.dart';

import '../models/habit.dart';

class EditHabitsRoute extends StatefulWidget {
  const EditHabitsRoute({Key? key, required this.userId}) : super(key: key);

  //userId for the current user (page owner)
  final String userId;

  @override
  State<EditHabitsRoute> createState() => _EditHabitsRouteState();
}

class _EditHabitsRouteState extends State<EditHabitsRoute> {
  //lists of widgets and text controllers for managing listview
  List<Widget> bodyElements = [];
  List<TextEditingController> controllers = [];
  Habit? template;

  late Future<void> future;
  late double screenHeight, screenWidth;

  void refresh(){
    setState(() {

    });
  }

  //initialize page
  @override
  void initState() {
    future = _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //get screen size values
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {Helper.replacePage(context, HabitsRoute(userId: widget.userId))}
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
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
              });
            },
          )
        ],
        backgroundColor: Helper.redColor,
        title: const Text(
          "Edit habits",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: screenWidth > 600 ? EdgeInsets.fromLTRB( screenWidth/8, 10, screenWidth/8, 10) : const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/whitewaves.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          children: <Widget>[
            FutureBuilder<void>(
              future:
              future, // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                Widget children;
                if (snapshot.connectionState != ConnectionState.done) {
                  children = Column(children: const [
                    SizedBox(
                      height: 200,
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Loading data...'),
                    ),
                  ]);
                } else {
                  children = Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: bodyElements,
                  );
                }
                return Center(
                  child: children,
                );
              },
            ),
          ],
        ),
      ),
      //wrap multiple buttons in the same wrap for them to appear side by side
      floatingActionButton: Wrap(
        //will break to another line on overflow
        direction: Axis.horizontal, //use vertical to show  on vertical axis
        children: <Widget>[
          Container(
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton.extended(
                backgroundColor: Colors.black,
                heroTag: "btn1",
                icon: const Icon(Icons.add),
                label: const Text('Add'),
                onPressed: () {
                  setState(() {
                    addBodyElement("", refresh);
                  });
                },
              )), // button third

          Container(
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton.extended(
                heroTag: "btn2",
                backgroundColor: Helper.redColor,
                icon: const Icon(
                  Icons.save,
                ),
                label: const Text('Save Changes'),
                onPressed: () {
                  List<HabitTask> newTasks = [];
                  controllers.map((e) => e.text.toString()).forEach((element) {
                    if(element.isNotEmpty) newTasks.add(HabitTask(element, false));
                  });
                  APIServices.patchHabit(
                      template!.id,
                      (DateTime.now().millisecondsSinceEpoch).toString(),
                      template!.note,
                      widget.userId,
                      APIServices.userId,
                      newTasks);

                  Helper.makeToast(context, "Habits saved!");
                },
              )),
        ],
      ),
    );
  }

  Future<void> _initialize() async {
    template = null;
    controllers.clear();
    bodyElements.clear();

    await APIServices.fetchTemplate(
        widget.userId,
            (http.Response res) =>
        {
          if(res.body.length > 2) {
            template = Habit.fromJson(jsonDecode(res.body)[0])
          }
        });

    if(template != null) {
      for (var element in template!.habits) {
        addBodyElement(element.task, refresh);
      }
    }
    else if(mounted){
      await APIServices.postHabit(
          context,
          (DateTime.now().millisecondsSinceEpoch).toString(),
          "Note",
          widget.userId,
          APIServices.userId,
          true,
          [HabitTask("Task 1", false)],
              (http.Response res) => {Helper.replacePage(context, EditHabitsRoute(userId: widget.userId))});
    }
  }

  //function for adding new task
  void addBodyElement(String name, Function() callback) {
    TextEditingController newController = TextEditingController();
    bodyElements.add(
      EditHabitHolder(newController: newController, bodyElements: bodyElements, screenWidth: screenWidth, controllers: controllers, callback: callback)
    );

    newController.text = name;
    controllers.add(newController);
  }
}
