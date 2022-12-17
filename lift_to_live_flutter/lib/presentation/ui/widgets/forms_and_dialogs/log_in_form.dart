import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/forms_and_dialogs/custom_form_button.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/forms_and_dialogs/custom_form_text_field.dart';
import 'package:lift_to_live_flutter/presentation/views/log_in_form_view.dart';
import '../../../presenters/log_in_page_presenter.dart';

/// Custom Form widget, which is nested in the LogInPage and is used for inputting user credentials
/// and submitting them for authentication. It implements the LogInFormView abstract class.
class LogInForm extends StatefulWidget implements LogInFormView {
  final double screenHeight, // height of the context screen
      screenWidth; // width of the context screen
  final TextEditingController _emailController =
          TextEditingController(), // controller for the email text field
      _passwordController =
          TextEditingController(); // controller for the password text field
  final LogInPagePresenter
      presenter; // the log in page presenter, holder of the log in page business logic

  // Simple constructor for the log in form instance, which takes the context screen dimensions and the business logic object.
  LogInForm(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.presenter});

  @override
  LogInFormState createState() {
    return LogInFormState();
  }

  /// Function to get the current email entry.
  @override
  String getEmail() {
    return _emailController.text.toString();
  }

  /// Function to get the current password entry.
  @override
  String getPassword() {
    return _passwordController.text.toString();
  }

  /// Function to clear the current email and password entries.
  @override
  void clearForm() {
    _emailController.clear();
    _passwordController.clear();
  }

  /// Function to clear the current password entry.
  @override
  void clearPassword() {
    _passwordController.clear();
  }
}

/// This class holds data and methods related to the log in form.
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
          CustomFormTextField(screenHeight: widget.screenHeight, screenWidth: widget.screenWidth, controller: widget._emailController, textInputType: TextInputType.emailAddress, hint: 'Enter email address', icon: Icons.email_outlined, validator: (value) {
            if (value != null &&
                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
              widget.clearForm();
              return 'Email must be in the right format (xxx@xxx.xxx)!';
            }
            return null;
          }, obscureText: false,),
          SizedBox(
            height: widget.screenHeight / 30,
          ),

          //password text field
          CustomFormTextField(screenHeight: widget.screenHeight, screenWidth: widget.screenWidth, controller: widget._passwordController, textInputType: TextInputType.text, hint: 'Enter password', icon: Icons.key, validator: (value) {
            if (value != null && value.length < 8) {
              widget.clearPassword();
              return 'Password must be at least 8 characters long!';
            }
            return null;
          }, obscureText: true,),
          SizedBox(
            height: widget.screenHeight / 20,
          ),

          //log in button
          CustomFormButton(screenHeight: widget.screenHeight, screenWidth: widget.screenWidth, title: 'Sign In', icon: Icons.login, function: () {
            if (_logInFormKey.currentState!.validate()) {
              widget.presenter.logIn();
            }
          }, tag: 'btn0'),
        ],
      ),
    );
  }
}
