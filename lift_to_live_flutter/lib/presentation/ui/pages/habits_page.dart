import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../factory/abstract_page_factory.dart';
import '../../presenters/habits_page_presenter.dart';
import '../../state_management/app_state.dart';
import '../../../helper.dart';
import '../../views/habits_page_view.dart';
import '../widgets/habit_related/custom_habits_calendar.dart';

/// Custom HabitsPage widget used as a main overview of the habit entries of a user.
/// It is a stateful widget and its state object implements the HabitsPageView abstract class.
class HabitsPage extends StatefulWidget {
  final String userId;
  final HabitsPagePresenter presenter; // The business logic object
  final AbstractPageFactory pageFactory;

  const HabitsPage({Key? key, required this.userId, required this.presenter, required this.pageFactory})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => HabitsPageState();
}

/// State object of the HabitsPage. Holds the mutable data, related to the page.
class HabitsPageState extends State<HabitsPage> implements HabitsPageView {
  bool _isLoading =
          false, // Indicator showing if data is being fetched at the moment
      _isFetched = false;
  late double screenHeight, screenWidth;
  late List<Widget> _habitsWidgets;

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
                        side: BorderSide(color: Helper.blackColor, width: 1),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    flexibleSpace: const FlexibleSpaceBar(
                      title: Text(
                        'My Habits',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w300),
                      ),
                      centerTitle: true,
                    ),
                    actions: [
                      IconButton(
                          onPressed: () async {
                            if (widget.presenter.isAuthorized()) {
                              Helper.pushPageWithSlideAnimation(
                                  context,
                                  widget.pageFactory.getEditHabitsPage(
                                    widget.userId,
                                  ));
                            } else {
                              Helper.makeToast(context,
                                  "You don't have the permission to edit habits!");
                            }
                          },
                          icon: const Icon(
                            Icons.edit_note,
                            color: Helper.yellowColor,
                          )),
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return _isFetched
                            ? CustomHabitsCalendar(habits: widget.presenter.habits)
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
                            //Divider(color: Helper.whiteColor, thickness: 1,),
                            Text(
                              'Habit Entries:',
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
                          child: _habitsWidgets[index],
                        );
                      },
                      childCount: _habitsWidgets.length,
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

  /// Function to notify if no habits were found
  @override
  void notifyNoHabitsFound() {
    Helper.makeToast(context,
        'No habit template was found! Ask your coach to set up your habit tasks!');
  }

  /// Function to set and display the habit data.
  @override
  void setHabitData(List<Widget> list) {
    setState(() {
      _habitsWidgets = list;
    });
  }
}
