import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/domain/entities/news.dart';
import 'package:lift_to_live_flutter/factory/home_page_factory.dart';
import 'package:lift_to_live_flutter/presentation/presenters/home_presenter.dart';
import 'package:lift_to_live_flutter/presentation/views/home_page_view.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/user.dart';
import '../../state_management/app_state.dart';
import '../../../helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> implements HomePageView {
  final HomePagePresenter _presenter = HomePageFactory().getHomePresenter();
  bool _isLoading = false, _isFetched = false;
  late News _currentNews;
  late User _user;
  late Image _profilePicture;
  late double _screenWidth, _screenHeight;

  @override
  void initState() {
    _presenter.attach(this);
    super.initState();
  }

  @override
  void deactivate() {
    _presenter.detach();
    super.deactivate();
  }

  @override
  void setInProgress(bool inProgress) {
    setState(() {
      _isLoading = inProgress;
    });
  }

  @override
  void setData(User user, Image profileImage, News news) {
    setState(() {
      _user = user;
      _currentNews = news;
      _profilePicture = profileImage;
    });
  }

  @override
  void setFetched(bool fetched) {
    setState(() {
      _isFetched = fetched;
    });
  }

  @override
  void notifyWrongURL(String s) {
    Helper.makeToast(context, s);
  }

  @override
  Widget build(BuildContext context) {
    if (!_presenter.isInitialized()) {
      _presenter.setAppState(Provider.of<AppState>(context));
    }

    if (!_isFetched) {
      _presenter.fetchData();
    }

    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        heroTag: 'btn4',
        //Floating action button on Scaffold
        onPressed: () {
          //code to execute on button press
        },
        backgroundColor: Helper.redColor,
        child: const Icon(Icons.fitness_center_outlined), //icon inside button
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //floating action button position to center

      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: Helper.blueColor,
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin: 5, //notch margin between floating button and bottom appbar
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox.fromSize(
              size: const Size(60, 60),
              child: ClipOval(
                child: InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    _presenter.habitsPressed(context, true);
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
                    _presenter.traineesPressed(context, true);
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
                    _presenter.profilePressed(context, true);
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
                            return AlertDialog(
                              title: const Text("Sign out"),
                              content: const Text(
                                  "Are you sure you want to sign out?"),
                              actions: [
                                IconButton(
                                    onPressed: () {
                                      _presenter.logOut(context);
                                    },
                                    icon: const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 30,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                      size: 30,
                                    ))
                              ],
                            );
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
                          : const SizedBox(height: 20,))
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
                                                  ? _user.phone_number
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
                _presenter.profilePressed(context, false);
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
                _presenter.habitsPressed(context, false);
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
                      _presenter.traineesPressed(context, false);
                    },
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
