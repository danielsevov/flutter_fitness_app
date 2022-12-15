import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../../helper.dart';
import '../../presenters/register_page_presenter.dart';
import '../../views/register_form_view.dart';

/// Custom Form widget, which is nested in the RegisterPage and is used for inputting user details
/// and submitting them for registration. It implements the RegisterFormView abstract class.
class RegisterForm extends StatefulWidget implements RegisterFormView {
  final double screenHeight, // height of the context screen
      screenWidth; // width of the context screen

  // controllers for the text fields
  final TextEditingController _emailController =
          TextEditingController(),
      _passwordController =
          TextEditingController(),
      _nameController = TextEditingController(),
      _phoneController = TextEditingController(),
      _dateController = TextEditingController(),
      _coachController = TextEditingController(),
      _nationalityController = TextEditingController();
  
  final RegisterPagePresenter
      presenter; // the register page presenter, holder of the business logic

  final List<String> coaches; // list of all coaches available

  // Simple constructor for the log in form instance, which takes the context screen dimensions and the business logic object.
  RegisterForm(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.presenter, required this.coaches});

  @override
  RegisterFormState createState() {
    return RegisterFormState();
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

  /// Function to clear the current entries.
  @override
  void clearForm() {
    _emailController.clear();
    _passwordController.clear();
    _nameController.clear();
    _nationalityController.clear();
    _phoneController.clear();
    _dateController.clear();
    _coachController.clear();
  }

  /// Function to clear the current password entry.
  @override
  void clearPassword() {
    _passwordController.clear();
  }

  @override
  void clearEmail() {
    _emailController.clear();
  }

  @override
  String getCoachEmail() {
    return _coachController.text.toString();
  }

  @override
  String getDateOfBirth() {
    return _dateController.text.toString();
  }

  @override
  String getName() {
    return _nameController.text.toString();
  }

  @override
  String getNationality() {
    return _nationalityController.text.toString();
  }

  @override
  String getPhoneNumber() {
    return _phoneController.text.toString();
  }
}

/// This class holds data and methods related to the log in form.
class RegisterFormState extends State<RegisterForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    widget._coachController.text = widget.presenter.appState.getUserId();
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _registerFormKey,
      child: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(
              height: 20
            ),
            /// name text field
            SizedBox(
              height: widget.screenHeight * 0.1,
              width: widget.screenWidth * 0.9,
              child: TextFormField(
                controller: widget._nameController,
                validator: (value) {
                  if (value == null || value.length < 2) {
                    widget._nameController.clear();
                    return 'Name has to be entered!';
                  }
                  return null;
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Helper.textFieldIconColor,
                  ),
                  filled : true, fillColor : Helper.blueColor,
                  errorStyle: const TextStyle(color: Helper.textFieldErrorColor),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Helper.textFieldBorderColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Helper.textFieldErrorColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Helper.textFieldErrorColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Helper.textFieldBorderColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Enter user name",
                  hintStyle: TextStyle(
                      color: Helper.textFieldHintColor,
                      fontSize: widget.screenHeight / 35,
                      height: 0.8),
                ),
                style: TextStyle(
                    color: Helper.textFieldTextColor,
                    fontSize: widget.screenHeight / 35,
                    height: 0.8),
              ),
            ),
            const SizedBox(
              height: 5
            ),

            /// email text field
            SizedBox(
              height: widget.screenHeight * 0.1,
              width: widget.screenWidth * 0.9,
              child: TextFormField(
                controller: widget._emailController,
                validator: (value) {
                  if (value == null ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return 'Email must be in the right format (xxx@xxx.xxx)!';
                  }
                  return null;
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Helper.textFieldIconColor,
                  ),
                  filled : true, fillColor : Helper.blueColor,
                  errorStyle: const TextStyle(color: Helper.textFieldErrorColor),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Helper.textFieldBorderColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Helper.textFieldErrorColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Helper.textFieldErrorColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Helper.textFieldBorderColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Enter user email address",
                  hintStyle: TextStyle(
                      color: Helper.textFieldHintColor,
                      fontSize: widget.screenHeight / 35,
                      height: 0.8),
                ),
                style: TextStyle(
                    color: Helper.textFieldTextColor,
                    fontSize: widget.screenHeight / 35,
                    height: 0.8),
              ),
            ),
            const SizedBox(
              height: 5
            ),

            /// password text field
            SizedBox(
              height: widget.screenHeight / 10,
              width: (widget.screenWidth / 10) * 9,
              child: TextFormField(
                controller: widget._passwordController,
                validator: (value) {
                  if (value == null || value.length < 8) {
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
                    color: Helper.textFieldIconColor,
                  ),
                  filled : true, fillColor : Helper.blueColor,
                  errorStyle: const TextStyle(color: Helper.textFieldErrorColor),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Helper.textFieldErrorColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Helper.textFieldErrorColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Helper.textFieldBorderColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Helper.textFieldBorderColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Enter user password",
                  hintStyle: TextStyle(
                      color: Helper.textFieldHintColor,
                      fontSize: widget.screenHeight / 35,
                      height: 0.8),
                ),
                style: TextStyle(
                    color: Helper.textFieldTextColor,
                    fontSize: widget.screenHeight / 35,
                    height: 0.8),
              ),
            ),
            const SizedBox(
              height: 5
            ),

            /// nationality text field
            SizedBox(
              height: widget.screenHeight * 0.1,
              width: widget.screenWidth * 0.9,
              child: TextFormField(
                controller: widget._nationalityController,
                validator: (value) {
                  if (value == null || value.length < 2) {
                    return 'Nationality has to be entered!';
                  }
                  return null;
                },
                onTap: () async {
                  // Below line stops keyboard from appearing
                  FocusScope.of(context).requestFocus(FocusNode());

                  // Show country picker
                  showCountryPicker(
                    showSearch: false,
                    countryListTheme: const CountryListThemeData(backgroundColor: Helper.blueColor, textStyle: TextStyle(color: Helper.whiteColor), searchTextStyle: TextStyle(color: Helper.whiteColor)),
                    context: context,
                    showPhoneCode: true, // optional. Shows phone code before the country name.
                    onSelect: (Country country) {
                      log('Select country: ${country.displayName}');
                      setState(() {
                        widget._nationalityController.text = country.name;
                        _registerFormKey.currentState?.validate();
                      });
                    },
                  );
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.location_pin,
                    color: Helper.textFieldIconColor,
                  ),
                  filled : true, fillColor : Helper.blueColor,
                  errorStyle: const TextStyle(color: Helper.textFieldErrorColor),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Helper.textFieldBorderColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Helper.textFieldErrorColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Helper.textFieldErrorColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Helper.textFieldBorderColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Enter user nationality",
                  hintStyle: TextStyle(
                      color: Helper.textFieldHintColor,
                      fontSize: widget.screenHeight / 35,
                      height: 0.8),
                ),
                style: TextStyle(
                    color: Helper.textFieldTextColor,
                    fontSize: widget.screenHeight / 35,
                    height: 0.8),
              ),
            ),
            const SizedBox(
              height: 5
            ),

            /// phone text field
            SizedBox(
              height: widget.screenHeight * 0.1,
              width: widget.screenWidth * 0.9,
              child: TextFormField(
                controller: widget._phoneController,
                validator: (value) {
                  if (value == null || value.length < 8 || value.length > 16) {
                    return 'Valid phone number has to be entered!';
                  }
                  return null;
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: Helper.textFieldIconColor,
                  ),
                  filled : true, fillColor : Helper.blueColor,
                  errorStyle: const TextStyle(color: Helper.textFieldErrorColor),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Helper.textFieldBorderColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Helper.textFieldErrorColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Helper.textFieldErrorColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Helper.textFieldBorderColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Enter user phone number",
                  hintStyle: TextStyle(
                      color: Helper.textFieldHintColor,
                      fontSize: widget.screenHeight / 35,
                      height: 0.8),
                ),
                style: TextStyle(
                    color: Helper.textFieldTextColor,
                    fontSize: widget.screenHeight / 35,
                    height: 0.8),
              ),
            ),
            const SizedBox(
              height: 5
            ),

            ///birth date text field
            SizedBox(
              height: widget.screenHeight * 0.1,
              width: widget.screenWidth * 0.9,
              child: TextFormField(
                controller: widget._dateController,
                validator: (value) {
                  if (widget._dateController.text.isEmpty) {
                    return 'Valid date of birth has to be entered!';
                  }
                  return null;
                },
                onTap: () async {
                  // Below line stops keyboard from appearing
                  FocusScope.of(context).requestFocus(FocusNode());

                  // Show date picker
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: Helper.blueColor, // <-- SEE HERE
                              onPrimary: Helper.whiteColor, // <-- SEE HERE
                              onSurface: Helper.blueColor,// <-- SEE HERE
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: Helper.blueColor, // button text color
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    log(pickedDate.toString()); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                    Helper.formatter.format(pickedDate);
                    log(formattedDate); //formatted date output using intl package =>  2021-03-16

                    setState(() {
                      widget._dateController.text =
                          formattedDate; //set output date to TextField value.
                      _registerFormKey.currentState?.validate();
                    });
                  } else {}
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.date_range,
                    color: Helper.textFieldIconColor,
                  ),
                  filled : true, fillColor : Helper.blueColor,
                  errorStyle: const TextStyle(color: Helper.textFieldErrorColor),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Helper.textFieldBorderColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Helper.textFieldErrorColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Helper.textFieldErrorColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Helper.textFieldBorderColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Enter user birth date",
                  hintStyle: TextStyle(
                      color: Helper.textFieldHintColor,
                      fontSize: widget.screenHeight / 35,
                      height: 0.8),
                ),
                style: TextStyle(
                    color: Helper.textFieldTextColor,
                    fontSize: widget.screenHeight / 35,
                    height: 0.8),
              ),
            ),
            const SizedBox(
              height: 5
            ),

            /// coach text field
            SizedBox(
              height: widget.screenHeight * 0.1,
              width: widget.screenWidth * 0.9,
              child: DropdownButtonFormField(
                items: widget.coaches.map((String coach) {
                  return DropdownMenuItem(
                      value: coach,
                      child: Text(coach)
                  );
                }).toList(),
                onChanged: (newValue) {
                  // do other stuff with _category
                  setState(() => widget._coachController.text = newValue as String);
                },
                value: widget._coachController.text,
                validator: (value) {
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.fitness_center,
                    color: Helper.textFieldIconColor,
                  ),
                  filled : true, fillColor : Helper.blueColor,
                  errorStyle: const TextStyle(color: Helper.textFieldErrorColor),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Helper.textFieldBorderColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Helper.textFieldErrorColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Helper.textFieldErrorColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Helper.textFieldBorderColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Enter coach ID",
                  hintStyle: TextStyle(
                      color: Helper.textFieldHintColor,
                      fontSize: widget.screenHeight / 35,
                      height: 0.8),
                ),
                style: TextStyle(
                    color: Helper.textFieldTextColor,
                    fontSize: widget.screenHeight / 35,
                    height: 0.8),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            /// submit form button
            SizedBox(
              width: widget.screenWidth < widget.screenHeight
                  ? widget.screenWidth / 2
                  : widget.screenWidth / 4,
              height: widget.screenHeight / 10,
              child: FittedBox(
                child: FloatingActionButton.extended(
                  heroTag: 'btn0',
                  onPressed: () async {
                    if (_registerFormKey.currentState!.validate()) {
                      widget.presenter.registerUser();
                    }
                  },
                  backgroundColor: Helper.yellowColor,
                  icon: const Icon(
                    Icons.check,
                    color: Helper.blueColor,
                  ),
                  label: const Text(
                    "Register User",
                    style: TextStyle(color: Helper.blueColor, fontSize: 24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
