import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../factory/abstract_page_factory.dart';
import '../../presenters/trainees_page_presenter.dart';
import '../../state_management/app_state.dart';
import '../../../helper.dart';
import '../../views/trainees_page_view.dart';
import '../widgets/user_related/trainee_search_holder.dart';

/// Custom TraineesPage widget used by coaches to search and overview trainees.
/// It provides navigation to the trainee's profile pages.
/// It is a stateful widget and its state object implements the TraineesPageView abstract class.
class TraineesPage extends StatefulWidget {
  final TraineesPagePresenter presenter; // The business logic object
  final AbstractPageFactory pageFactory;

  const TraineesPage({Key? key, required this.presenter, required this.pageFactory}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TraineesPageState();
}

/// State object of the TraineesPage. Holds the mutable data, related to the profile page.
class TraineesPageState extends State<TraineesPage>
    implements TraineesPageView {
  bool _isLoading =
          false, // Indicator showing if data is being fetched at the moment
      _isFetched = false;
  late List<TraineeSearchHolder> _userWidgets;
  final TextEditingController searchController = TextEditingController();
  late double screenHeight, screenWidth;

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

  /// Function to set and display the user details, user profile picture.
  @override
  void setUserData(List<TraineeSearchHolder> users) {
    setState(() {
      _userWidgets = users;
      _isFetched = true;
    });
  }

  /// Function to show a toast message when no user data can be fetched.
  @override
  Future<void> notifyNoUserData() async {
    Helper.makeToast(context, 'No trainees data has been fetched!!');
  }

  /// Function to navigate to the selected user profile page
  @override
  void navigateToProfilePage(String id) {
    Helper.pushPageWithSlideAnimation(
        context, widget.pageFactory.getProfilePage(id, 'trainees'));
  }

  /// Function called when user wants to navigate to the user registration page.
  @override
  void registerPressed(BuildContext context) {
    Helper.replacePageWithSlideAnimation(context, widget.pageFactory.getRegisterPage());
  }

  /// Function to apply the search term filter on the trainees
  void refreshList() {
    setState(() {});
  }

  /// Build method of the home page view
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Helper.actionButtonColor,
        heroTag: "btn3",
        icon: const Icon(
          CupertinoIcons.profile_circled,
          color: Helper.blackColor,
        ),
        label: const Text(
          'Register User',
          style: TextStyle(color: Helper.blackColor),
        ),
        onPressed: () {
          registerPressed(context);
        },
      ),
      appBar: AppBar(
        backgroundColor: Helper.lightBlueColor.withOpacity(0.9),
        elevation: 20,
        centerTitle: true,
        title: const Text(
          "My Trainees",
          style: TextStyle(color: Helper.headerBarTextColor),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Helper.yellowColor, //change your color here
        ),
      ),
      body: _isLoading
          ? const Center(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: CircularProgressIndicator(
            color: Helper.yellowColor,
          ),
        ),
      )
          : SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Helper.pageBackgroundImage),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: screenWidth - 20,
                child: TextField(
                  onTap: () {},
                  onChanged: (searchTerm) {
                    refreshList();
                  },
                  controller: searchController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Helper.yellowColor, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Helper.whiteColor.withOpacity(0.3), width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Helper.dividerColor,
                    ),
                    hintText: "Search user",
                    hintStyle: const TextStyle(
                        color: Helper.textFieldHintColor,
                        fontSize: 24,
                        height: 0.8),
                  ),
                  style: const TextStyle(
                      color: Helper.textFieldTextColor,
                      fontSize: 20,
                      height: 0.8),
                ),
              ),
              Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          height: screenHeight / 1.4,
                          width: screenWidth > 500 ? 500 : screenWidth,
                          child: ListView(
                            children: _userWidgets
                                .where((element) =>
                                    element.user.name.toLowerCase().contains(
                                        searchController.text.toLowerCase()) ||
                                    element.user.email.toLowerCase().contains(
                                        searchController.text.toLowerCase()))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
