import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../../../helper.dart';
import '../../../presenters/register_page_presenter.dart';
import '../../../views/register_form_view.dart';
import '../reusable_elements/custom_form_button.dart';
import '../reusable_elements/custom_form_dropdown_text_field.dart';
import '../reusable_elements/custom_form_text_field.dart';

/// Custom Form widget, which is nested in the RegisterPage and is used for inputting user details
/// and submitting them for registration. It implements the RegisterFormView abstract class.
class RegisterForm extends StatefulWidget implements RegisterFormView {
  final double screenHeight, // height of the context screen
      screenWidth; // width of the context screen

  // controllers for the text fields
  final TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController(),
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
      required this.presenter,
      required this.coaches});

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

  void enterData(String name, String email, String pass, String phone) {
    _nameController.text = name;
    _emailController.text = email;
    _passwordController.text = pass;
    _phoneController.text = phone;
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
            const SizedBox(height: 20),

            /// name text field
            CustomFormTextField(
              screenHeight: widget.screenHeight,
              screenWidth: widget.screenWidth,
              controller: widget._nameController,
              textInputType: TextInputType.text,
              hint: 'Enter user name',
              icon: Icons.person,
              obscureText: false,
              validator: (value) {
                if (value == null || value.length < 2) {
                  widget._nameController.clear();
                  return 'Name has to be entered!';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            /// email text field
            CustomFormTextField(
              screenHeight: widget.screenHeight,
              screenWidth: widget.screenWidth,
              controller: widget._emailController,
              textInputType: TextInputType.emailAddress,
              hint: 'Enter user email address',
              icon: Icons.email_outlined,
              obscureText: false,
              validator: (value) {
                if (value == null ||
                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                  return 'Email must be in the right format (xxx@xxx.xxx)!';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            /// password text field
            CustomFormTextField(
              screenHeight: widget.screenHeight,
              screenWidth: widget.screenWidth,
              controller: widget._passwordController,
              textInputType: TextInputType.text,
              hint: 'Enter user password',
              icon: Icons.key,
              obscureText: true,
              validator: (value) {
                if (value == null || value.length < 8) {
                  return 'Password must be at least 8 characters long!';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            /// nationality text field
            CustomFormTextField(
              screenHeight: widget.screenHeight,
              screenWidth: widget.screenWidth,
              controller: widget._nationalityController,
              textInputType: TextInputType.text,
              hint: 'Enter user nationality',
              icon: Icons.location_pin,
              obscureText: false,
              validator: (value) {
                if (value == null || value.length < 2) {
                  return 'Nationality has to be entered!';
                }
                return null;
              },
              onTap: () {
                // Below line stops keyboard from appearing
                FocusScope.of(context).requestFocus(FocusNode());

                // Show country picker
                showCountryPicker(
                  showSearch: false,
                  countryListTheme: const CountryListThemeData(
                      backgroundColor: Helper.blueColor,
                      textStyle: TextStyle(color: Helper.whiteColor),
                      searchTextStyle: TextStyle(color: Helper.whiteColor)),
                  context: context,
                  showPhoneCode:
                      true, // optional. Shows phone code before the country name.
                  onSelect: (Country country) {
                    log('Select country: ${country.displayName}');
                    setState(() {
                      widget._nationalityController.text = country.name;
                      _registerFormKey.currentState?.validate();
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 20),

            /// phone text field
            CustomFormTextField(
              screenHeight: widget.screenHeight,
              screenWidth: widget.screenWidth,
              controller: widget._phoneController,
              textInputType: TextInputType.phone,
              hint: 'Enter user phone number',
              icon: Icons.phone,
              obscureText: false,
              validator: (value) {
                if (value == null || value.length < 8 || value.length > 16) {
                  return 'Valid phone number has to be entered!';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            ///birth date text field
            CustomFormTextField(
              screenHeight: widget.screenHeight,
              screenWidth: widget.screenWidth,
              controller: widget._dateController,
              textInputType: TextInputType.datetime,
              hint: 'Enter user birth date',
              icon: Icons.date_range,
              obscureText: false,
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
                            onSurface: Helper.blueColor, // <-- SEE HERE
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  Helper.blueColor, // button text color
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
                  log(pickedDate
                      .toString()); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate = Helper.formatter.format(pickedDate);
                  log(formattedDate); //formatted date output using intl package =>  2021-03-16

                  setState(() {
                    widget._dateController.text =
                        formattedDate; //set output date to TextField value.
                    _registerFormKey.currentState?.validate();
                  });
                } else {}
              },
            ),
            const SizedBox(height: 20),

            /// coach text field
            CustomFormDropdownTextField(
                screenHeight: widget.screenHeight,
                screenWidth: widget.screenWidth,
                controller: widget._coachController,
                textInputType: TextInputType.text,
                hint: 'Enter coach ID',
                icon: Icons.fitness_center,
                obscureText: false,
                onChanged: (newValue) {
                  // do other stuff with _category
                  setState(
                      () => widget._coachController.text = newValue as String);
                  _registerFormKey.currentState?.validate();
                },
                items: widget.coaches, isEnabled: true,),
            const SizedBox(
              height: 20,
            ),

            /// submit form button
            CustomFormButton(
                screenHeight: widget.screenHeight,
                screenWidth: widget.screenWidth,
                title: 'Register User',
                icon: Icons.check,
                function: () {
                  if (_registerFormKey.currentState!.validate()) {
                    widget.presenter.registerUser();
                  }
                },
                tag: 'btn0'),
          ],
        ),
      ),
    );
  }
}
