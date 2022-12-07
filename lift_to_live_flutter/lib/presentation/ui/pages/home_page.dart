import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/domain/entities/news.dart';
import 'package:lift_to_live_flutter/factory/home_page_factory.dart';
import 'package:lift_to_live_flutter/presentation/presenters/home_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/habits_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/profile_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/trainees_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/log_out_dialog.dart';
import 'package:lift_to_live_flutter/presentation/views/home_page_view.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/user.dart';
import '../../state_management/app_state.dart';
import '../../../helper.dart';
import 'log_in_page.dart';

/// Custom widget, which is the HomePage and is used as a main navigational hub for the application.
/// It provides navigation to the main app pages, as well as a news overview and the log out functionality.
/// It is a stateful widget and its state object implements the HomePageView abstract class.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

/// State object of the HomePage. Holds the mutable data, related to the home page.
class HomePageState extends State<HomePage> implements HomePageView {
  final HomePagePresenter _presenter = HomePageFactory()
      .getHomePagePresenter(); // The business logic object of the log in page
  bool _isLoading =
          false, // Indicator showing if data is being fetched at the moment
      _isFetched = false; // Indicator showing if data is already fetched
  late News _currentNews; // The object holding the news articles
  late User
      _user; // The user object holding the details of the current logged in user
  late Image
      _profilePicture; // The image object holding the current user profile picture
  late double _screenWidth, _screenHeight; // The screen dimensions

  /// initialize the page view by attaching it to the presenter
  @override
  void initState() {
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

  /// Function to set and display the user details, user profile picture.
  @override
  void setUserData(User user, Image profileImage) {
    setState(() {
      _user = user;
      _profilePicture = profileImage;
    });
  }

  /// Function to set and display the list of news.
  @override
  void setNewsData(News news) {
    setState(() {
      _currentNews = news;
    });
  }

  /// Function to indicate that the required data has been fetched, so appropriate layout can be displayed.
  @override
  void setFetched(bool fetched) {
    setState(() {
      _isFetched = fetched;
    });
  }

  /// Function to show a toast message when a news URL is incorrect.
  @override
  void notifyWrongURL(String s) {
    Helper.makeToast(context, s);
  }

  /// Function called when user wants to navigate from home to habit page
  @override
  void habitsPressed(BuildContext context, bool bottomBarButton) {
    if (!bottomBarButton) Navigator.of(context).pop();
    Helper.pushPageWithAnimation(context, HabitsPage(userId: _user.id));
  }

  /// Function called when user wants to navigate from home to profile page
  @override
  void profilePressed(BuildContext context, bool bottomBarButton) {
    if (!bottomBarButton) Navigator.of(context).pop();
    Helper.pushPageWithAnimation(
        context,
        ProfilePage(
          userId: _user.id,
          originPage: 'home',
        ));
  }

  /// Function called when user wants to navigate from home to trainees page
  /// This is only allowed if user is admin or coach.
  @override
  void traineesPressed(BuildContext context, bool bottomBarButton) {
    if (!bottomBarButton) Navigator.of(context).pop();
    if (_presenter.isCoachOrAdmin()) {
      Helper.pushPageWithAnimation(context, const TraineesPage());
    } else {
      Helper.makeToast(context, "Become coach to access this page!");
    }
  }

  /// Function to clear the app state upon log out and navigate to log in page
  @override
  void logOutPressed(BuildContext context) {
    _presenter.logOut();
    Helper.pushPageWithAnimation(context, const LogInPage());
  }

  /// Build method of the home page view
  @override
  Widget build(BuildContext context) {
    // get screen dimensions
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    // initialize presenter and log in form, if not initialized yet
    if (!_presenter.isInitialized()) {
      _presenter.setAppState(Provider.of<AppState>(context));
    }

    // fetch data if it is not fetched yet
    if (!_isFetched) {
      _presenter.fetchData();
    }

    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton.large(
        heroTag: 'btn4',
        //Floating action button on Scaffold
        onPressed: () {
          //TODO code to execute on button press
          try {
            DefaultBottomBarController.of(context).swap();
          }
          catch (e) {}
        },
        backgroundColor: Helper.actionButtonColor,
        child: const Icon(
          Icons.fitness_center_outlined,
          color: Helper.actionButtonTextColor,
        ), //icon inside button
      ),

      //floating action button position to center
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // bottom navigation bar on scaffold
      bottomNavigationBar: BottomExpandableAppBar(
        bottomAppBarColor: Helper.pageBackgroundColor,
        expandedHeight: 230,
        expandedBody: Container(
          width: _screenWidth * 0.7,
          decoration: const BoxDecoration(
              color: Helper.lightBlueColor,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 60,),
              FloatingActionButton.extended(heroTag: 'startworkoutbutton', onPressed: () {},icon: const Icon(Icons.fitness_center, color: Helper.blackColor,),backgroundColor: Helper.yellowColor, label: const Text('Start Workout', style: TextStyle(fontSize: 24, color: Helper.blackColor),)),
              const SizedBox(height: 10,),
              FloatingActionButton.extended(heroTag: 'edittemplatesbutton', onPressed: () {},icon: const Icon(Icons.edit_note),backgroundColor: Helper.redColor, label: const Text('Edit Templates', style: TextStyle(fontSize: 24, color: Helper.paragraphTextColor),)),
              const SizedBox(height: 10,),
              FloatingActionButton.extended(heroTag: 'viewhistorybutton', onPressed: () {},icon: const Icon(Icons.history),backgroundColor: Helper.blackColor, label: const Text('View History', style: TextStyle(fontSize: 24, color: Helper.paragraphTextColor),)),
              const SizedBox(height: 10,),
            ],),
          ),
        ),
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin: 5, //notch margin between floating button and bottom appbar
        //children inside bottom appbar
        bottomAppBarBody: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox.fromSize(
              size: const Size(60, 60),
              child: ClipOval(
                child: InkWell(
                  splashColor: Helper.whiteColor,
                  onTap: () {
                    habitsPressed(context, true);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.task,
                        color: Helper.bottomBarIconColor,
                      ), // <-- Icon
                      Text(
                        "Habits",
                        style: TextStyle(color: Helper.bottomBarTextColor),
                      ), // <-- Text
                    ],
                  ),
                ),
              ),
            ),
            SizedBox.fromSize(
              size: const Size(60, 60),
              child: ClipOval(
                child: InkWell(
                  splashColor: Helper.whiteColor,
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.edit_calendar,
                        color: Helper.bottomBarIconColor,
                      ), // <-- Icon
                      Text(
                        "Calendar",
                        style: TextStyle(color: Helper.bottomBarTextColor),
                      ), // <-- Text
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(),
            const SizedBox(),
            SizedBox.fromSize(
              size: const Size(60, 60),
              child: ClipOval(
                child: InkWell(
                  splashColor: Helper.whiteColor,
                  onTap: () {
                    traineesPressed(context, true);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.people,
                        color: Helper.bottomBarIconColor,
                      ), // <-- Icon
                      Text(
                        "Trainees",
                        style: TextStyle(color: Helper.bottomBarTextColor),
                      ), // <-- Text
                    ],
                  ),
                ),
              ),
            ),
            SizedBox.fromSize(
              size: const Size(60, 60),
              child: ClipOval(
                child: InkWell(
                  splashColor: Helper.whiteColor,
                  onTap: () {
                    profilePressed(context, true);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        CupertinoIcons.profile_circled,
                        color: Helper.bottomBarIconColor,
                      ), // <-- Icon
                      Text(
                        "Profile",
                        style: TextStyle(color: Helper.bottomBarTextColor),
                      ), // <-- Text
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Helper.pageBackgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Helper.pageBackgroundColor.withOpacity(0.7),
              iconTheme: const IconThemeData(
                color: Helper.darkHeadlineColor, //change your color here
              ),
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 100.0,
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              actions: [
                IconButton(
                    //on pressed clear token and navigate to log in page
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return LogOutDialog(view: this);
                          });
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Helper.darkHeadlineColor,
                    )),
              ],
              flexibleSpace: const FlexibleSpaceBar(
                title: Text(
                  "L I F T    T O    L I V E",
                  style: TextStyle(color: Helper.headerBarTextColor),
                ),
                centerTitle: true,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Hero(
                    tag: 'logo',
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                      child: Image.asset(
                        Helper.logoImage,
                        width: _screenWidth * 0.8,
                        height: _screenHeight * 0.5,
                      ),
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Scroll down and check what\'s new in the gym world!',
                      style: TextStyle(color: Helper.lightHeadlineColor),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _isLoading
                      ? (index == 0
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Helper.yellowColor,
                            ))
                          : const SizedBox(
                              height: 3,
                            ))
                      : Container(
                          color: index.isOdd
                              ? Helper.lightBlueColor
                              : Helper.paragraphBackgroundColor
                                  .withOpacity(0.12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 160,
                                    height: 80,
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(20)),
                                        child: _currentNews.articles[index]
                                                .urlToImage.isEmpty
                                            ? null
                                            : Image.network(
                                                _currentNews
                                                    .articles[index].urlToImage,
                                                loadingBuilder: (context, child,
                                                        loadingProgress) =>
                                                    (loadingProgress == null)
                                                        ? child
                                                        : const Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: Helper
                                                                  .pageBackgroundColor,
                                                            ),
                                                          ),
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Container(
                                                  height: 80,
                                                  width: 160,
                                                  color: Helper.backgroundColor,
                                                ),
                                                scale: 0.1,
                                                height: 80,
                                                width: 160,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _currentNews.articles[index].title,
                                      style: const TextStyle(
                                          color: Helper.defaultTextColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${_currentNews.articles[index].description}\n\n${_currentNews.articles[index].content}',
                                  style: const TextStyle(
                                    color: Helper.defaultTextColor,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FloatingActionButton.extended(
                                    heroTag: index.toString(),
                                    onPressed: () async {
                                      _presenter.redirectToURL(index);
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.arrow_turn_down_right,
                                      color: Helper.actionButtonTextColor,
                                    ),
                                    label: const Text('Read More', style: TextStyle(color: Helper.blackColor),),
                                    backgroundColor: Helper.actionButtonColor,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        width: _screenWidth > 300 ? 300 : _screenWidth / 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(90), bottomRight: Radius.circular(0)),
        ),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: _screenHeight / 7 * 4,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                    color: Helper.pageBackgroundColor,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(90))),
                child: Wrap(
                  children: [
                    _screenHeight > 300
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: _isFetched
                                      ? _profilePicture
                                      : Image.asset(
                                          'assets/images/prof_pic.png',
                                          height: 100),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 20,
                      width: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          _isFetched ? _user.name : '',
                          style: const TextStyle(
                              color: Helper.defaultTextColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    _screenHeight > 520
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.email_outlined,
                                              color: Helper.yellowColor,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              _isFetched ? _user.email : '',
                                              style: const TextStyle(
                                                  color:
                                                      Helper.defaultTextColor,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              CupertinoIcons.phone,
                                              color: Helper.yellowColor,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              _isFetched
                                                  ? _user.phoneNumber
                                                  : '',
                                              style: const TextStyle(
                                                  color:
                                                      Helper.defaultTextColor,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              CupertinoIcons.location_solid,
                                              color: Helper.yellowColor,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              _isFetched
                                                  ? _user.nationality
                                                  : '',
                                              style: const TextStyle(
                                                  color:
                                                      Helper.defaultTextColor,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                  ],
                ),
              ),
            ),
            ListTile(
              tileColor: Helper.blueColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(0)),
              ),
              title: Row(
                children: const [
                  Icon(
                    CupertinoIcons.profile_circled,
                    color: Helper.yellowColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 22,
                      color: Helper.defaultTextColor,
                    ),
                  )
                ],
              ),
              onTap: () {
                profilePressed(context, false);
              },
            ),
            ListTile(
              tileColor: Helper.lightBlueColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0),
                    topRight: Radius.circular(0)),
              ),
              title: Row(
                children: const [
                  Icon(Icons.task_alt_outlined, color: Helper.yellowColor),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'My Habits',
                    style:
                        TextStyle(fontSize: 22, color: Helper.defaultTextColor),
                  )
                ],
              ),
              onTap: () async {
                habitsPressed(context, false);
              },
            ),
            ListTile(
              tileColor: Helper.blueColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(0)),
              ),
              title: Row(
                children: const [
                  Icon(
                    Icons.fitness_center_outlined,
                    color: Helper.yellowColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Manage Workouts',
                    style: TextStyle(
                      fontSize: 22,
                      color: Helper.defaultTextColor,
                    ),
                  )
                ],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _presenter.isCoachOrAdmin()
                ? ListTile(
                    tileColor: Helper.lightBlueColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(0)),
                    ),
                    title: Row(
                      children: const [
                        Icon(
                          Icons.people,
                          color: Helper.yellowColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Manage Trainees',
                          style: TextStyle(
                            fontSize: 22,
                            color: Helper.defaultTextColor,
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      traineesPressed(context, false);
                    },
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
