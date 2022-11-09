import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/factory/log_in_factory.dart';
import 'package:lift_to_live_flutter/presentation/presenters/log_in_presenter.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/home_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/log_in_form.dart';
import 'package:provider/provider.dart';

import '../../state_management/app_state.dart';
import '../../../helper.dart';
import '../../views/log_in_form_view.dart';
import '../../views/log_in_page_view.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LogInPageState();
}

class LogInPageState extends State<LogInPage> implements LogInPageView {
  final LogInPresenter _presenter = LogInFactory().getTokenPresenter();
  late final LogInForm _logInForm;
  bool _isLoading = false;
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
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    if (!_presenter.isInitialized()) {
      _presenter.setAppState(Provider.of<AppState>(context));
      _logInForm = LogInForm(screenHeight: _screenHeight, screenWidth: _screenWidth, presenter: _presenter);
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
            borderRadius: BorderRadius.circular(30), image: const DecorationImage(
            image: AssetImage("assets/images/whitewaves.png"),
            fit: BoxFit.cover,
          ),),
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

              _isLoading ? const Center(child: CircularProgressIndicator(color: Helper.blueColor,)) : _logInForm
            ],
          ),
        ),
      ),
    );
  }

  @override
  LogInFormView getLogInForm() {
    return _logInForm;
  }

  @override
  void setInProgress(bool inProgress) {
    setState(() {
      _isLoading = inProgress;
    });
  }

  @override
  void navigateToHome() {
    Helper.pushPageWithAnimation(
        context,
        const HomePage());
  }

  @override
  void notifyWrongCredentials() {
    Helper.makeToast(context, "Email or password is wrong!");
  }
}
