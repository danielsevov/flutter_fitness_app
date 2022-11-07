import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/factory/log_in_factory.dart';
import 'package:lift_to_live_flutter/presentation/presenters/log_in_presenter.dart';
import 'package:lift_to_live_flutter/presentation/ui/home_page.dart';
import 'package:provider/provider.dart';

import '../state_management/app_state.dart';
import '../../helper.dart';
import '../views/log_in_view.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LogInPageState();
}

class LogInPageState extends State<LogInPage> implements LogInView {
  final LogInPresenter _presenter = LogInFactory().getTokenPresenter();
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController();
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
    if (!_presenter.isInitialized()) {
      _presenter.setAppState(Provider.of<AppState>(context));
    }

    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

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

              _isLoading ? const Center(child: CircularProgressIndicator(color: Helper.blueColor,)) : Column(
                children: [
                  //email text field
                  SizedBox(
                    height: _screenHeight/10,
                    width: (_screenWidth / 10) * 9,
                    child: TextField(
                      controller: _emailController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Helper.blueColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Helper.blueColor, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Enter email address",
                        hintStyle: TextStyle(
                            color: Colors.blueGrey, fontSize: _screenHeight/30, height: 0.8),
                      ),
                      style: TextStyle(
                          color: Helper.blueColor, fontSize: _screenHeight/30, height: 0.8),
                    ),
                  ),
                  SizedBox(
                    height: _screenHeight/30,
                  ),

                  //password text field
                  SizedBox(
                    height: _screenHeight/10,
                    width: (_screenWidth / 10) * 9,
                    child: TextField(
                      controller: _passwordController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.key,
                          color: Helper.blueColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Helper.blueColor, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Enter password",
                        hintStyle: TextStyle(
                            color: Colors.blueGrey, fontSize: _screenHeight/30, height: 0.8),
                      ),
                      style: TextStyle(
                          color: Helper.blueColor, fontSize: _screenHeight/30, height: 0.8),
                    ),
                  ),
                  SizedBox(
                    height: _screenHeight/20,
                  ),

                  //log in button
                  SizedBox(
                    width: _screenWidth < _screenHeight ?
                    _screenWidth / 2 : _screenWidth/4,
                    height: _screenHeight/10,
                    child: FittedBox(
                      child: FloatingActionButton.extended(
                        heroTag: 'btn0',
                        onPressed: () async {
                          _presenter.logIn(context);
                        },
                        backgroundColor: Helper.blueColor,
                        icon: const Icon(
                          Icons.login,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  String getEmail() {
    return _emailController.text.toString();
  }

  @override
  String getPassword() {
    return _passwordController.text.toString();
  }

  @override
  void setInProgress(bool inProgress) {
    setState(() {
      _isLoading = inProgress;
    });
  }

  @override
  void clearForm() {
    setState(() {
      _emailController.clear();
      _passwordController.clear();
    });
  }

  @override
  void clearPassword() {
    setState(() {
      _passwordController.clear();
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
