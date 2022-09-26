import 'dart:convert';

import 'package:first_solo_flutter_app/pages/home_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../api_services.dart';
import '../helper.dart';
import '../models/token.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late TextEditingController myEmailController, myPassController;
  late double screenHeight, screenWidth;

  @override
  void initState() {
    //initialize TextField controllers
    myPassController = TextEditingController();
    myEmailController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //get screen size values
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Helper.blueColor,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight - 20,
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
                  'assets/images/lifttolive.png',
                  height: screenHeight / 2,
                ),
              ),

              //email text field
              SizedBox(
                height: screenHeight/10,
                width: (screenWidth / 10) * 9,
                child: TextField(
                  controller: myEmailController,
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
                        color: Colors.blueGrey, fontSize: screenHeight/30, height: 0.8),
                  ),
                  style: TextStyle(
                      color: Helper.blueColor, fontSize: screenHeight/30, height: 0.8),
                ),
              ),
              SizedBox(
                height: screenHeight/30,
              ),

              //password text field
              SizedBox(
                height: screenHeight/10,
                width: (screenWidth / 10) * 9,
                child: TextField(
                  controller: myPassController,
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
                        color: Colors.blueGrey, fontSize: screenHeight/30, height: 0.8),
                  ),
                  style: TextStyle(
                      color: Helper.blueColor, fontSize: screenHeight/30, height: 0.8),
                ),
              ),
              SizedBox(
                height: screenHeight/20,
              ),

              //log in button
              SizedBox(
                width: screenWidth < screenHeight ? screenWidth / 2 : screenWidth/4,
                height: screenHeight/10,
                child: FittedBox(
                  child: FloatingActionButton.extended(
                    heroTag: 'btn0',
                    onPressed: () async {
                      //log in debug mode autofill user credentials
                      if (kDebugMode &&
                          myPassController.text.isEmpty &&
                          myEmailController.text.isEmpty) {
                        myEmailController.text = "danielsevov@gmail.com";
                        myPassController.text = "titikakaon4o";
                      }

                      if (verifyCredentials()) {
                        var res = await APIServices.logIn(
                            myEmailController.text, myPassController.text);

                        //if not successful clear form
                        if (res.statusCode != 200) {
                          myPassController.clear();

                          if (!mounted) return;
                          Helper.makeToast(context,
                              "The provided Email address or password are incorrect!");
                          return;
                        }

                        //if successful log in
                        else {
                          //store token and userId
                          Map<String, dynamic> userMap = jsonDecode(res.body);

                          APIServices.jwtToken = Token.fromJson(userMap).token;
                          APIServices.userId =
                              myEmailController.text.toString();
                          await APIServices.initializeUserRoles();

                          //navigate to home page
                          if (!mounted) return;
                          Helper.pushPageWithAnimation(
                              context,
                              const HomeRoute());
                        }
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
        ),
      ),
    );
  }

  bool verifyCredentials() {
    //check email format
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(myEmailController.value.text)) {
      Helper.makeToast(
          context, "Email must be in the right format (xxx@xxx.xxx)!");
      return false;
    }

    //verify password
    else if (myPassController.value.text.characters.length < 8) {
      Helper.makeToast(context, "Password must be at least 8 characters long!");
      return false;
    }

    //verified successfully
    return true;
  }
}
