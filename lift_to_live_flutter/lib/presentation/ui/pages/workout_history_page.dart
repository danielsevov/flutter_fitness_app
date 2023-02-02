import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/custom_workouts_calendar.dart';
import 'package:provider/provider.dart';
import '../../../factory/abstract_page_factory.dart';
import '../../presenters/workout_history_page_presenter.dart';
import '../../state_management/app_state.dart';
import '../../../helper.dart';
import '../../views/workout_history_page_view.dart';

/// Custom WorkoutHistoryPage widget used as a main overview of the habit entries of a user.
/// It is a stateful widget and its state object implements the WorkoutHistoryPageView abstract class.
class WorkoutHistoryPage extends StatefulWidget {
  final String userId;
  final WorkoutHistoryPagePresenter presenter; // The business logic object
  final AbstractPageFactory pageFactory;

  const WorkoutHistoryPage(
      {Key? key, required this.userId, required this.presenter, required this.pageFactory})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => WorkoutHistoryPageState();
}

/// State object of the WorkoutHistoryPage. Holds the mutable data, related to the page.
class WorkoutHistoryPageState extends State<WorkoutHistoryPage>
    implements WorkoutHistoryPageView {
  bool _isLoading =
          false, // Indicator showing if data is being fetched at the moment
      _isFetched = false;
  late double screenHeight, screenWidth;
  late List<Widget> _workoutWidgets;
  late List<String> _workoutDates;

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
  void notifyNoWorkoutsFound() {
    Helper.makeToast(context, 'No workout entries were found!');
  }

  /// Function to set and display the workout data.
  @override
  void setWorkoutData(List<Widget> list, List<String> dates) {
    setState(() {
      _workoutWidgets = list;
      _workoutDates = dates;
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
      body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Helper.pageBackgroundImage),
              fit: BoxFit.fill,
            ),
          ),
          child: (!_isLoading && _isFetched)
              ? CustomScrollView(slivers: <Widget>[
                  SliverAppBar(
                    leading: IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Helper.yellowColor),
                        onPressed: () {
                          Helper.replacePageWithSlideAnimation(
                              context,
                              widget.pageFactory
                                  .getWrappedHomePage());
                        }),
                    iconTheme: const IconThemeData(
                      color: Helper.yellowColor, //change your color here
                    ),
                    backgroundColor: Helper.lightBlueColor.withOpacity(0.9),
                    elevation: 20,
                    pinned: true,
                    snap: true,
                    floating: true,
                    expandedHeight: 100.0,
                    shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    flexibleSpace: const FlexibleSpaceBar(
                      title: Text(
                        'Workout History',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w300),
                      ),
                      centerTitle: true,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: widget.userId == widget.presenter.appState.getUserId() ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
                              children: [
                                 widget.userId == widget.presenter.appState.getUserId() ? FloatingActionButton.extended(
                                  backgroundColor: Helper.yellowColor,
                                  onPressed: () {
                                    Helper.pushPageWithSlideAnimation(
                                        context,
                                        widget.pageFactory
                                            .getWorkoutPage(0,
                                                widget.userId, false, false));
                                  },
                                  icon: const Icon(
                                    Icons.fitness_center_outlined,
                                    color: Helper.blackColor,
                                  ),
                                  heroTag: 'startNewWorkoutButton',
                                  label: const Text(
                                    'Start Workout',
                                    style: TextStyle(
                                        color: Helper.blackColor,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ) : const SizedBox(),
                                FloatingActionButton.extended(
                                  backgroundColor: Helper.redColor,
                                  onPressed: () {
                                    if (widget.presenter.isAuthorized()) {
                                      Helper.pushPageWithSlideAnimation(
                                          context,
                                          widget.pageFactory.getWorkoutTemplatesPage(
                                              widget.userId));
                                    } else {
                                      Helper.makeToast(context,
                                          "You don't have the permission to edit workouts!");
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.view_carousel,
                                    color: Helper.whiteColor,
                                  ),
                                  heroTag: 'viewTemplatesButton',
                                  label: const Text(
                                    'Templates',
                                    style: TextStyle(
                                        color: Helper.whiteColor,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return _isFetched
                            ? CustomWorkoutCalendar(workoutDates: _workoutDates)
                            : const SizedBox();
                      },
                      childCount: 1,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Column(
                          children: const [
                            Text(
                              'Workout Entries:',
                              style: TextStyle(
                                  color: Helper.whiteColor, fontSize: 22),
                            ),
                            Divider(
                              color: Helper.whiteColor,
                              thickness: 1,
                            ),
                          ],
                        );
                      },
                      childCount: 1,
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
                  )
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
