import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/habits_page.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/habit.dart';
import '../../presenters/edit_habits_page_presenter.dart';
import '../../../factory/habits_page_factory.dart';
import '../../state_management/app_state.dart';
import '../../../helper.dart';
import '../../views/edit_habits_page_view.dart';
import '../widgets/edit_habit_holder.dart';

// coverage:ignore-file
/// Custom EditHabitsPage widget used as a main editorial page of the habit template of a user.
/// It is a stateful widget and its state object implements the EditHabitsPageView abstract class.
class EditHabitsPage extends StatefulWidget {
  final String userId;

  const EditHabitsPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditHabitsPageState();
}

/// State object of the HabitsPage. Holds the mutable data, related to the profile page.
class EditHabitsPageState extends State<EditHabitsPage>
    implements EditHabitsPageView {
  late EditHabitsPagePresenter _presenter; // The business logic object
  bool _isLoading =
          false, // Indicator showing if data is being fetched at the moment
      _isFetched = false;
  late double screenHeight, screenWidth;
  bool _isChanged = false;

  //lists of widgets and text controllers for managing listview
  List<Widget> bodyElements = [];
  List<TextEditingController> controllers = [];

  late Habit template;

  /// initialize the page view by attaching it to the presenter
  @override
  void initState() {
    _isChanged = false;
    _presenter = HabitsPageFactory().getEditHabitsPagePresenter(widget.userId);
    _presenter.attach(this);
    super.initState();
  }

  /// detach the view from the presenter
  @override
  void deactivate() {
    _presenter.detach();
    super.deactivate();
  }

  /// Function to set if data is currently being fetched and an loading indicator should be displayed.
  @override
  void setInProgress(bool inProgress) {
    setState(() {
      _isLoading = inProgress;
    });
  }

  /// Function to set if data is fetched and should be displayed.
  @override
  void setFetched(bool inProgress) {
    setState(() {
      _isFetched = inProgress;
    });
  }

  /// Build method of the home page view
  @override
  Widget build(BuildContext context) {
    //get screen size values
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    // initialize presenter and log in form, if not initialized yet
    if (!_presenter.isInitialized()) {
      _presenter.setAppState(Provider.of<AppState>(context));
    }

    // fetch data if it is not fetched yet
    if (!_isFetched) {
      _presenter.fetchData();
    }

    return Scaffold(
      backgroundColor: Helper.blueColor,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Helper.yellowColor),
            onPressed: () => {
                  _isChanged ? goBack() : Navigator.pop(context)
                }),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Helper.yellowColor, //change your color here
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
        backgroundColor: Helper.lightBlueColor,
        title: const Text(
          "Edit habits",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: screenWidth > 600
            ? EdgeInsets.fromLTRB(screenWidth / 8, 10, screenWidth / 8, 10)
            : const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Helper.pageBackgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: _isFetched && !_isLoading
            ? ListView(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: bodyElements,
                  ),
                ],
              )
            : const Center(
                child: Padding(
                padding: EdgeInsets.all(15.0),
                child: CircularProgressIndicator(
                  color: Helper.yellowColor,
                ),
              )),
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
                  _presenter.addNewElement();
                },
              )), // button third

          Container(
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton.extended(
                heroTag: "btn2",
                backgroundColor: Helper.yellowColor,
                icon: const Icon(
                  Icons.save,
                  color: Helper.blackColor,
                ),
                label: const Text(
                  'Save Changes',
                  style: TextStyle(color: Helper.blackColor),
                ),
                onPressed: () {
                  _presenter.saveChanges();
                },
              )),
        ],
      ),
    );
  }

  @override
  void addTaskElement(String name, Function() callback) {
    setState(() {
      TextEditingController newController = TextEditingController();
      bodyElements.add(EditHabitHolder(
          newController: newController,
          bodyElements: bodyElements,
          screenWidth: screenWidth,
          controllers: controllers,
          callback: callback));

      newController.text = name;
      controllers.add(newController);
    });
  }

  @override
  void clear() {
    controllers.clear();
    bodyElements.clear();
  }

  @override
  refresh() {
    setState(() {});
  }

  @override
  List<TextEditingController> getControllers() {
    return controllers;
  }

  @override
  void notifySavedChanges() {
    _isChanged = true;
    Helper.makeToast(context, "All habit changes have been saved!");
  }

  void goBack() {
    Navigator.pop(context);
    Helper.replacePage(context, HabitsPage(userId: widget.userId));
  }
}
