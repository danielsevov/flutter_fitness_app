import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/presentation/presenters/log_in_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/home_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/log_in_form.dart';
import 'package:provider/provider.dart';

import '../../../factory/home_page_factory.dart';
import '../../state_management/app_state.dart';
import '../../../helper.dart';
import '../../views/log_in_form_view.dart';
import '../../views/log_in_page_view.dart';

/// Custom widget, which is the LogInPage and is used for inputting user credentials
/// and submitting them for authentication and communicating with the user.
/// It is a stateful widget and its state object implements the LogInPageView abstract class.
class LogInPage extends StatefulWidget {
  final LogInPagePresenter presenter;

  const LogInPage({super.key, required this.presenter}); // The business logic object of the log in page


  @override
  State<StatefulWidget> createState() => LogInPageState();
}

/// State object of the LogInPage. Holds the mutable data, related to the log in page.
class LogInPageState extends State<LogInPage> implements LogInPageView {
  late final LogInForm
      _logInForm; // The log in form widget, nested in the log in page
  bool _isLoading =
      false; // Indicator showing if data is being fetched at the moment
  late double _screenWidth, _screenHeight; // Dimensions of the screen

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

  /// Build method of the log in page view
  @override
  Widget build(BuildContext context) {
    // get screen dimensions
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    // initialize presenter and log in form, if not initialized yet
    if (!widget.presenter.isInitialized()) {
      widget.presenter.setAppState(Provider.of<AppState>(context));
      _logInForm = LogInForm(
          screenHeight: _screenHeight,
          screenWidth: _screenWidth,
          presenter: widget.presenter);
    }

    return Scaffold(
      backgroundColor: Helper.blueColor,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          width: _screenWidth,
          height: _screenHeight - 20,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: const DecorationImage(
              image: AssetImage("assets/images/whitewaves.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //logo image
              Hero(
                tag: 'logo',
                child: Image.asset(
                  "assets/images/lifttolive.png",
                  height: _screenHeight / 2,
                ),
              ),

              // display loading indicator if data is being processed
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Helper.blueColor,
                    ))
                  : _logInForm
            ],
          ),
        ),
      ),
    );
  }

  /// Function to allow access to the log in Form.
  @override
  LogInFormView getLogInForm() {
    return _logInForm;
  }

  /// Function to set if data is currently being fetched and an loading indicator should be displayed.
  @override
  void setInProgress(bool inProgress) {
    setState(() {
      _isLoading = inProgress;
    });
  }

  /// Function to trigger page change from log in page to home page, upon successful log in.
  @override
  void navigateToHome() {
    Helper.pushPageWithAnimation(context, HomePage(presenter: HomePageFactory()
        .getHomePagePresenter(),));
  }

  /// Function to display a toast message, when user cannot be authenticated.
  @override
  void notifyWrongCredentials() {
    Helper.makeToast(context, "Email or password is wrong!");
  }
}
