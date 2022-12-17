import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../factory/page_factory.dart';
import '../../presenters/register_page_presenter.dart';
import '../../state_management/app_state.dart';
import '../../../helper.dart';
import '../../views/register_form_view.dart';
import '../../views/register_page_view.dart';
import '../widgets/forms_and_dialogs/register_form.dart';

/// Custom widget, which is the RegisterPage and is used for inputting user details
/// and submitting them for registration of the user.
/// It is a stateful widget and its state object implements the RegisterPageView abstract class.
class RegisterPage extends StatefulWidget {
  final RegisterPagePresenter presenter; // The business logic object of the log in page

  const RegisterPage({Key? key, required this.presenter}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

/// State object of the RegisterPage. Holds the mutable data, related to the register page.
class RegisterPageState extends State<RegisterPage>
    implements RegisterPageView {
  late final RegisterForm
      _registerForm; // The log in form widget, nested in the log in page
  bool _isLoading = false,
      _isFetched =
          false; // Indicator showing if data is being fetched at the moment
  late double _screenWidth, _screenHeight;

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

  /// Build method of the register page view
  @override
  Widget build(BuildContext context) {
    // get screen dimensions
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    // initialize presenter and log in form, if not initialized yet
    if (!widget.presenter.isInitialized()) {
      widget.presenter.setAppState(Provider.of<AppState>(context));
    }

    // fetch data if it is not fetched yet
    if (!_isFetched) {
      widget.presenter.fetchData();
    }

    return Scaffold(
      backgroundColor: Helper.pageBackgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Helper.pageBackgroundColor.withOpacity(0.7),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Helper.yellowColor),
            onPressed: () {
              Helper.replacePage(context, PageFactory().getTraineesPage());
            }
        ),
        title: const Text(
          "Register User",
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
      body: Container(
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
          child:
              // display loading indicator if data is being processed
              _isLoading || !_isFetched
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Helper.yellowColor,
                    ))
                  : _registerForm),
    );
  }

  /// Function to allow access to the register form.
  @override
  RegisterFormView getRegisterForm() {
    return _registerForm;
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

  /// Function to display a toast message, when user cannot be registered due to duplicated email.
  @override
  void notifyEmailAlreadyExists() {
    Helper.makeToast(context, "Email already exists in the system!");
  }

  /// Function to notify the user that registering a new user failed due to unexpected exception.
  @override
  void notifyRegisterFailed() {
    Helper.makeToast(context,
        "Something went wrong while registering user, please try again later!");
  }

  /// Function to notify the user that he has successfully registered a new user.
  @override
  void notifyUserRegistered() {
    Helper.makeToast(context, "User has been successfully registered!");
    Helper.replacePage(context, PageFactory().getTraineesPage());
  }

  /// Function to pass the required coach data to the page view.
  @override
  void setCoachData(List<String> coachesIds) {
    setState(() {
      _registerForm = RegisterForm(
        screenHeight: _screenHeight,
        screenWidth: _screenWidth,
        presenter: widget.presenter,
        coaches: coachesIds,
      );
    });
  }
}
