import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/factory/page_factory.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/user.dart';
import '../../presenters/profile_page_presenter.dart';
import '../../state_management/app_state.dart';
import '../../../helper.dart';
import '../../views/profile_page_view.dart';


/// Custom ProfilePage widget used as a main overview of a user.
/// It provides navigation to the user's pictures and habits pages.
/// It is a stateful widget and its state object implements the ProfilePageView abstract class.
class ProfilePage extends StatefulWidget {
  final ProfilePagePresenter presenter; // The business logic object of the log in page
  final String userId;
  final String originPage;

  const ProfilePage({Key? key, required this.userId, required this.originPage, required this.presenter}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

/// State object of the ProfilePage. Holds the mutable data, related to the profile page.
class ProfilePageState extends State<ProfilePage> implements ProfilePageView {
  bool _isLoading =
          false, // Indicator showing if data is being fetched at the moment
  _isFetched = false;
  late User
      _user; // The user object holding the details of the current logged in user
  late Image
      _profilePicture; // The image object holding the current user profile picture
  late double _screenWidth; // The screen dimensions

  /// initialize the page view by attaching it to the presenter
  @override
  void initState() {
    widget.presenter.attach(this);
    super.initState();
  }

  /// detach the view from the widget.presenter
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

  /// Function to set and display the user details, user profile picture.
  @override
  void setUserData(User user, Image profileImage) {
    setState(() {
      _user = user;
      _profilePicture = profileImage;
      _isFetched = true;
    });
  }

  /// Function called when user wants to change the profile picture.
  @override
  void changeProfilePicture(Image image) {
    setState(() {
      _profilePicture = image;
    });
  }

  /// Function to show a toast message when no user data can be fetched.
  @override
  void notifyNoUserData() {
    Helper.makeToast(context, 'No user data found!');
  }

  /// Function called when user wants to navigate from the users profile to the users habit page.
  @override
  void habitsPressed(BuildContext context) {
    Helper.pushPageWithAnimation(context, PageFactory().getHabitsPage(_user.id));
  }

  /// Function called when user wants to navigate from profile page to pictures page.
  @override
  void picturesPressed(BuildContext context) {
    Helper.pushPageWithAnimation(context, PageFactory().getPicturePage(_user.id, _user.name.split(" ")[0],));
  }

  /// Build method of the profile page view
  @override
  Widget build(BuildContext context) {
    // get screen dimensions
    _screenWidth = MediaQuery.of(context).size.width;

    // initialize widget.presenter and log in form, if not initialized yet
    if (!widget.presenter.isInitialized()) {
      widget.presenter.setAppState(Provider.of<AppState>(context));
    }

    // fetch data if it is not fetched yet
    if (!_isFetched) {
      widget.presenter.fetchData();
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
        SliverAppBar(centerTitle: true,
          backgroundColor: Helper.pageBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          pinned: true,
          snap: true,
          floating: true,
          iconTheme: const IconThemeData(
            color: Helper.headerBarIconColor, //change your color here
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Helper.yellowColor),
              onPressed: () {
                if(widget.originPage == 'home') {
                  Helper.replacePage(context, PageFactory().getWrappedHomePage());
                }
                else if(widget.originPage == 'trainees') {
                  Navigator.pop(context);
                }
                else {
                  Navigator.pop(context);
                }
              }
          ),
          expandedHeight: 100.0,
          flexibleSpace: FlexibleSpaceBar(
            title: _isFetched ? Text(_user.name, style: const TextStyle(fontSize: 25, color: Helper.lightHeadlineColor),) : const Text('Profile Page', style: TextStyle(fontWeight: FontWeight.w600, color: Helper.lightHeadlineColor),),
            centerTitle: true,
          ),),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return _isLoading ? const Center(child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(color: Helper.yellowColor,),
                )) : SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(image: DecorationImage(
                      image: AssetImage(Helper.pageBackgroundImage),
                      fit: BoxFit.fill,
                    ),),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Wrap( //will break to another line on overflow
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.spaceAround,//use vertical to show  on vertical axis
                          children: <Widget>[
                            Container(
                                margin:const EdgeInsets.all(10),
                                child: FloatingActionButton.extended(
                                  heroTag: 'btn5',
                                  backgroundColor: Helper.actionButtonColor,
                                  label: const Text('View Pictures', style: TextStyle(color: Helper.actionButtonTextColor),),
                                  onPressed: () async {
                                    if(widget.presenter.isAuthorized(false)) {
                                      Helper.pushPageWithAnimation(context, PageFactory().getPicturePage(_user.id, _user.name.split(" ")[0],));
                                    }
                                    else {
                                      Helper.makeToast(context, 'You are not authorized to see this page!');
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.photo_library_rounded,
                                    color: Helper.actionButtonTextColor,
                                  ),
                                )
                            ), // button second
                            const SizedBox(height: 10,),
                            Container(
                                margin:const EdgeInsets.all(10),
                                child: FloatingActionButton.extended(
                                  heroTag: 'btn6',
                                  backgroundColor: Helper.redColor,
                                  icon: const Icon(Icons.task, color: Helper.whiteColor,),
                                  label: const Text('View Habits', style: TextStyle(color: Helper.whiteColor),),
                                  onPressed: () {
                                    habitsPressed(context);
                                  },
                                )
                            ), // button third

                            // Add more buttons here
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.presenter.isAuthorized(true) ? const SizedBox(width: 50,) : const SizedBox(),
                            Container(
                              height: _screenWidth / 2,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Helper.blackColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: _isFetched ? _profilePicture : null,
                              ),
                            ),
                            widget.presenter.isAuthorized(true) && _isFetched ? IconButton(onPressed: () {widget.presenter.changeProfilePicture();}, icon: const Icon(CupertinoIcons.camera_fill, color: Helper.iconBackgroundColor, size: 30,)) : const SizedBox()
                          ],
                        ),
                        const SizedBox(height: 20,),
                        const Text('User details:', style: TextStyle(color: Helper.lightHeadlineColor, fontSize: 22, fontWeight: FontWeight.w600),),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                width: _screenWidth * 0.8,
                                decoration: BoxDecoration(
                                    color: Helper.paragraphBackgroundColor,
                                    borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Helper.whiteColor),),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.email_outlined,
                                              color: Helper.paragraphIconColor, size: 25,
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            SizedBox(
                                              child: Text(
                                                _user.email,
                                                style: const TextStyle(
                                                    color: Helper.paragraphTextColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              CupertinoIcons.phone,
                                              color: Helper.paragraphIconColor, size: 25,
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              _user.phoneNumber,
                                              style: const TextStyle(
                                                  color: Helper.paragraphTextColor),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(CupertinoIcons.location_solid,
                                                color: Helper.paragraphIconColor, size: 25),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              _user.nationality,
                                              style: const TextStyle(
                                                  color: Helper.paragraphTextColor),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.date_range,
                                                color: Helper.paragraphIconColor, size: 25),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              _user.dateOfBirth,
                                              style: const TextStyle(
                                                  color: Helper.paragraphTextColor),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.fitness_center_outlined,
                                              color: Helper.paragraphIconColor, size: 25,),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              _user.coachId,
                                              style: const TextStyle(
                                                  color: Helper.paragraphTextColor),
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
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          )]),
    );
  }
}
