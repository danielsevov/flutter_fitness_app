import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/domain/entities/news.dart';
import 'package:lift_to_live_flutter/factory/home_page_factory.dart';
import 'package:lift_to_live_flutter/presentation/presenters/home_page_presenter.dart';
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

/// State object of the HomePage. Holds the mutable data, related to the log in page.
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
    Helper.pushPageWithAnimation(context, const Text("Habits"));
  }

  /// Function called when user wants to navigate from home to profile page
  @override
  void profilePressed(BuildContext context, bool bottomBarButton) {
    if (!bottomBarButton) Navigator.of(context).pop();
    Helper.pushPageWithAnimation(context, const Text("Profile"));
  }

  /// Function called when user wants to navigate from home to trainees page
  /// This is only allowed if user is admin or coach.
  @override
  void traineesPressed(BuildContext context, bool bottomBarButton) {
    if (!bottomBarButton) Navigator.of(context).pop();
    if (_presenter.isCoachOrAdmin()) {
      Helper.pushPageWithAnimation(context, const Text("Trainees"));
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
      floatingActionButton: FloatingActionButton.large(
        heroTag: 'btn4',
        //Floating action button on Scaffold
        onPressed: () {
          //TODO code to execute on button press
        },
        backgroundColor: Helper.redColor,
        child: const Icon(Icons.fitness_center_outlined), //icon inside button
      ),

      //floating action button position to center
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // bottom navigation bar on scaffold
      bottomNavigationBar: BottomAppBar(
        color: Helper.blueColor,
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin: 5, //notch margin between floating button and bottom appbar
        //children inside bottom appbar
          child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox.fromSize(
              size: const Size(60, 60),
              child: ClipOval(
                child: InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    habitsPressed(context, true);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.task,
                        color: Colors.white,
                      ), // <-- Icon
                      Text(
                        "Habits",
                        style: TextStyle(color: Colors.white),
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
                  splashColor: Colors.white,
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.edit_calendar,
                        color: Colors.white,
                      ), // <-- Icon
                      Text(
                        "Calendar",
                        style: TextStyle(color: Colors.white),
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
                  splashColor: Colors.white,
                  onTap: () {
                    traineesPressed(context, true);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.people,
                        color: Colors.white,
                      ), // <-- Icon
                      Text(
                        "Trainees",
                        style: TextStyle(color: Colors.white),
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
                  splashColor: Colors.white,
                  onTap: () {
                    profilePressed(context, true);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        CupertinoIcons.profile_circled,
                        color: Colors.white,
                      ), // <-- Icon
                      Text(
                        "Profile",
                        style: TextStyle(color: Colors.white),
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
            image: AssetImage("assets/images/whitewaves.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Helper.blueColor,
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
                      color: Colors.white,
                    )),
              ],
              flexibleSpace: const FlexibleSpaceBar(
                title: Text("LiftToLive"),
                centerTitle: true,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Hero(
                    tag: 'logo',
                    child: Image.asset(
                      "assets/images/lifttolive.png",
                      height: _screenHeight / 1.5,
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
                    Text('Scroll down and check what\'s new in the gym world!')
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
                              color: Helper.blueColor,
                            ))
                          : const SizedBox(
                              height: 3,
                            ))
                      : Container(
                          color: index.isOdd
                              ? Colors.white
                              : Helper.blueColor.withOpacity(0.12),
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
                                                                  .blueColor,
                                                            ),
                                                          ),
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Container(
                                                  height: 80,
                                                  width: 160,
                                                  color: Colors.white,
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
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '${_currentNews.articles[index].description}\n\n${_currentNews.articles[index].content}'),
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
                                      color: Colors.white,
                                    ),
                                    label: const Text('Read More'),
                                    backgroundColor: Helper.blueColor,
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
              height: _screenHeight / 2,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                    color: Helper.blueColor,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(90))),
                child: Wrap(
                  children: [
                    _screenHeight > 300
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 50,
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
                      height: 10,
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
                              color: Colors.white,
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
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              _isFetched ? _user.email : '',
                                              style: const TextStyle(
                                                  color: Colors.white70,
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
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              _isFetched
                                                  ? _user.phoneNumber
                                                  : '',
                                              style: const TextStyle(
                                                  color: Colors.white70,
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
                                                color: Colors.white),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              _isFetched
                                                  ? _user.nationality
                                                  : '',
                                              style: const TextStyle(
                                                  color: Colors.white70,
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
                  Icon(CupertinoIcons.profile_circled, color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'My Profile',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  )
                ],
              ),
              textColor: Helper.blueColor,
              onTap: () {
                profilePressed(context, false);
              },
            ),
            ListTile(
              tileColor: Helper.redColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0),
                    topRight: Radius.circular(0)),
              ),
              title: Row(
                children: const [
                  Icon(Icons.task_alt_outlined, color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'My Habits',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  )
                ],
              ),
              textColor: Helper.redColor,
              onTap: () async {
                habitsPressed(context, false);
              },
            ),
            ListTile(
              tileColor: Colors.black,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(0)),
              ),
              title: Row(
                children: const [
                  Icon(Icons.fitness_center_outlined, color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Manage Workouts',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  )
                ],
              ),
              textColor: Colors.black,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _presenter.isCoachOrAdmin()
                ? ListTile(
                    tileColor: Helper.blueColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(0)),
                    ),
                    title: Row(
                      children: const [
                        Icon(Icons.people, color: Colors.white),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Manage Trainees',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        )
                      ],
                    ),
                    textColor: Helper.blueColor,
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
