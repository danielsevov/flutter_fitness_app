import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../factory/page_factory.dart';
import '../../presenters/workout_templates_page_presenter.dart';
import '../../state_management/app_state.dart';
import '../../../helper.dart';
import '../../views/workout_templates_page_view.dart';

/// Custom WorkoutTemplatesPage widget used as a main overview of the habit entries of a user.
/// It is a stateful widget and its state object implements the WorkoutTemplatesPageView abstract class.
class WorkoutTemplatesPage extends StatefulWidget {
  final String userId;
  final WorkoutTemplatesPagePresenter presenter; // The business logic object

  const WorkoutTemplatesPage({Key? key, required this.userId, required this.presenter})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => WorkoutTemplatesPageState();
}

/// State object of the WorkoutTemplatesPage. Holds the mutable data, related to the page.
class WorkoutTemplatesPageState extends State<WorkoutTemplatesPage> implements WorkoutTemplatesPageView {
  bool _isLoading =
          false, // Indicator showing if data is being fetched at the moment
      _isFetched = false;
  late double screenHeight, screenWidth;
  late List<Widget> _workoutWidgets;

  /// initialize the page view by attaching it to the presenter
  @override
  void initState() {
    widget.presenter.attach(this);
    super.initState();
  }

  /// detach the view from the presenter
  @override
  void deactivate() {
    widget.presenter.detach();
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

  /// Function to notify if no workouts were found
  @override
  void notifyNoTemplateWorkoutsFound() {
    Helper.makeToast(context,
        'No workout entries were found!');
  }

  /// Function to notify a template has been copied
  @override
  void notifyNewTemplate() {
    Helper.makeToast(context,
        'Template has been copied!');
    Navigator.pop(context);
  }

  /// Function to set and display the workout template data.
  @override
  void setWorkoutData(List<Widget> list) {
    setState(() {
      _workoutWidgets = list;
    });
  }

  /// Build method of the habits page view
  @override
  Widget build(BuildContext context) {
    //get screen size values
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    // initialize presenter and log in form, if not initialized yet
    if (!widget.presenter.isInitialized()) {
      widget.presenter.setAppState(Provider.of<AppState>(context));
    }

    // fetch data if it is not fetched yet
    if (!_isFetched) {
      widget.presenter.fetchData();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(heroTag: 'addNewTemplateButton', onPressed: (){
        Helper.replacePage(context, PageFactory().getWorkoutPage(0, widget.userId, true, true));
      }, backgroundColor: Helper.yellowColor,label: const Text('Add Template', style: TextStyle(color: Helper.blackColor, fontWeight: FontWeight.w700),), icon: const Icon(Icons.add, color: Helper.blackColor,),),
      body: Container(
        padding: const EdgeInsets.only(bottom: 50),
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Helper.pageBackgroundImage),
              fit: BoxFit.fill,
            ),
          ),
          child: (!_isLoading && _isFetched)
              ? CustomScrollView(slivers: <Widget>[
                  const SliverAppBar(
                    iconTheme: IconThemeData(
                      color: Helper.yellowColor, //change your color here
                    ),
                    backgroundColor: Helper.lightBlueColor,
                    pinned: true,
                    snap: true,
                    floating: true,
                    expandedHeight: 100.0,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        'Templates',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w300),
                      ),
                      centerTitle: true,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          color: index.isOdd
                              ? Helper.blueColor.withOpacity(0.12)
                              : Helper.blueColor.withOpacity(0.12),
                          padding: const EdgeInsets.all(10),
                          child: _workoutWidgets[index],
                        );
                      },
                      childCount: _workoutWidgets.length,
                    ),
                  ),
                ])
              : const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                      color: Helper.yellowColor,
                    ),
                ),
              )),
    );
  }
}
