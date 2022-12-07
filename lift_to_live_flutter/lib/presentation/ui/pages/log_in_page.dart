import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/factory/home_page_factory.dart';
import 'package:lift_to_live_flutter/factory/log_in_page_factory.dart';
import 'package:lift_to_live_flutter/presentation/presenters/log_in_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/log_in_form.dart';
import 'package:provider/provider.dart';

import '../../state_management/app_state.dart';
import '../../../helper.dart';
import '../../views/log_in_form_view.dart';
import '../../views/log_in_page_view.dart';

/// Custom widget, which is the LogInPage and is used for inputting user credentials
/// and submitting them for authentication and communicating with the user.
/// It is a stateful widget and its state object implements the LogInPageView abstract class.
class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LogInPageState();
}

/// State object of the LogInPage. Holds the mutable data, related to the log in page.
class LogInPageState extends State<LogInPage> implements LogInPageView {
  final LogInPagePresenter _presenter = LogInPageFactory()
      .getLogInPresenter(); // The business logic object of the log in page
  late final LogInForm
      _logInForm; // The log in form widget, nested in the log in page
  bool _isLoading =
      false; // Indicator showing if data is being fetched at the moment
  late double _screenWidth, _screenHeight; // Dimensions of the screen

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

  /// Build method of the log in page view
  @override
  Widget build(BuildContext context) {
    // get screen dimensions
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    // initialize presenter and log in form, if not initialized yet
    if (!_presenter.isInitialized()) {
      _presenter.setAppState(Provider.of<AppState>(context));
      _logInForm = LogInForm(
          screenHeight: _screenHeight,
          screenWidth: _screenWidth,
          presenter: _presenter);
    }

    Future<bool> _onWillPop() async {
      return false; //<-- SEE HERE
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Helper.pageBackgroundColor,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            width: _screenWidth,
            height: _screenHeight - 20,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: const DecorationImage(
                image: AssetImage(Helper.pageBackgroundImage),
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
                    Helper.logoImage,
                    height: _screenHeight * 0.5,
                    width: _screenWidth * 0.8,
                  ),
                ),

                // display loading indicator if data is being processed
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Helper.yellowColor,
                      ))
                    : _logInForm
              ],
            ),
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
    Helper.pushPageWithAnimation(
        context, HomePageFactory().getWrappedHomePage());
  }

  /// Function to display a toast message, when user cannot be authenticated.
  @override
  void notifyWrongCredentials() {
    Helper.makeToast(context, "Email or password is wrong!");
  }
}
