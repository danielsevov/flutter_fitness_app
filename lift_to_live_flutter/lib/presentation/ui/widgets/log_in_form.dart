import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/presentation/views/log_in_form_view.dart';

import '../../../helper.dart';
import '../../presenters/log_in_presenter.dart';

// Define a custom Form widget.
class LogInForm extends StatefulWidget implements LogInFormView{
  final double screenHeight, screenWidth;
  final TextEditingController _emailController = TextEditingController(), _passwordController = TextEditingController();
  final LogInPresenter presenter;

  LogInForm({super.key, required this.screenHeight, required this.screenWidth, required this.presenter});

  @override
  LogInFormState createState() {
    return LogInFormState();
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
  void clearForm() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  void clearPassword() {
    _passwordController.clear();
  }
}

// This class holds data related to the log in form.
class LogInFormState extends State<LogInForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _logInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _logInFormKey,
      child: Column(
        children: [
          //email text field
          SizedBox(
            height: widget.screenHeight/10,
            width: (widget.screenWidth / 10) * 9,
            child: TextFormField(
              controller: widget._emailController,
              validator: (value) {
                if (value != null && !RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  widget.clearForm();
                  return 'Email must be in the right format (xxx@xxx.xxx)!';
                }
                return null;
              },
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Helper.blueColor,
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Helper.blueColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                errorBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Helper.blueColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                hintText: "Enter email address",
                hintStyle: TextStyle(
                    color: Colors.blueGrey, fontSize: widget.screenHeight/35, height: 0.8),
              ),
              style: TextStyle(
                  color: Helper.blueColor, fontSize: widget.screenHeight/35, height: 0.8),
            ),
          ),
          SizedBox(
            height: widget.screenHeight/30,
          ),

          //password text field
          SizedBox(
            height: widget.screenHeight/10,
            width: (widget.screenWidth / 10) * 9,
            child: TextFormField(
              controller: widget._passwordController,
              validator: (value) {
                if (value != null && value.length < 8) {
                  widget.clearPassword();
                  return 'Password must be at least 8 characters long!';
                }
                return null;
              },
              textAlign: TextAlign.center,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.key,
                  color: Helper.blueColor,
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                errorBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Helper.blueColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Helper.blueColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                hintText: "Enter password",
                hintStyle: TextStyle(
                    color: Colors.blueGrey, fontSize: widget.screenHeight/35, height: 0.8),
              ),
              style: TextStyle(
                  color: Helper.blueColor, fontSize: widget.screenHeight/35, height: 0.8),
            ),
          ),
          SizedBox(
            height: widget.screenHeight/20,
          ),

          //log in button
          SizedBox(
            width: widget.screenWidth < widget.screenHeight ?
            widget.screenWidth / 2 : widget.screenWidth/4,
            height: widget.screenHeight/10,
            child: FittedBox(
              child: FloatingActionButton.extended(
                heroTag: 'btn0',
                onPressed: () async {
                  if (_logInFormKey.currentState!.validate()) {
                    widget.presenter.logIn(context);
                  }
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
      ),
    );
  }
}