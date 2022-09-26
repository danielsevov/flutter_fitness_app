import 'dart:convert';

import 'package:first_solo_flutter_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:first_solo_flutter_app/token.dart';
import 'package:http/http.dart' as http;

import '../Helper.dart';
import '../models/role.dart';
import 'home_route.dart';

//Log in page providing log in form
class LogInRoute extends StatefulWidget {
  const LogInRoute({Key? key}) : super(key: key);

  @override
  State<LogInRoute> createState() => _LogInRouteState();
}

class _LogInRouteState extends State<LogInRoute> {
  //Controllers for email and password text fields
  final myEmailController = TextEditingController(),
      myPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // NEW from here ...
      body: Stack(
        children: <Widget>[
          //Container for the logo image
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/images/lifttolive.png',
                height: MediaQuery.of(context).size.height / 1.5),
          ),
          //Container for the form
          Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.fromLTRB(20.0, 380, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: myEmailController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Helper.blueColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      hintText: "Enter email address",
                      hintStyle: TextStyle(
                          color: Colors.blueGrey, fontSize: 20, height: 0.8),
                    ),
                    style: const TextStyle(
                        color: Helper.blueColor, fontSize: 20, height: 0.8),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: myPassController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.key,
                        color: Helper.blueColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Helper.blueColor),
                      ),
                      hintText: "Enter password",
                      hintStyle: TextStyle(
                          color: Colors.blueGrey, fontSize: 20, height: 0.8),
                    ),
                    style: const TextStyle(
                        color: Helper.blueColor, fontSize: 20, height: 0.8),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  //Container for the login button
                  Container(
                    padding: const EdgeInsets.only(
                        left: 50.0, top: 5, bottom: 5, right: 50.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Helper.blueColor,
                    ),
                    child: TextButton(
                        //on pressed check credentials and log in
                        onPressed: () async {
                          //TODO instant login remove later
                          if (kDebugMode &&
                              myPassController.text.isEmpty &&
                              myEmailController.text.isEmpty) {
                            myEmailController.text = "danielsevov@gmail.com";
                            myPassController.text = "titikakaon4o";
                          }
                          //verify email
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(myEmailController.value.text)) {
                            Helper.makeToast(
                                context, "Email must be in the right format!");
                            return;
                          }
                          //verify password
                          else if (myPassController
                                  .value.text.characters.length <
                              8) {
                            Helper.makeToast(context,
                                "Password must be at least 8 characters long!");
                            return;
                          }
                          //make login http request
                          else {
                            http.Response res = await Helper.logIn(
                                myEmailController.text, myPassController.text);

                            //if not successful clear form
                            if (res.statusCode != 200) {
                              myPassController.clear();

                              await Future.delayed(const Duration(seconds: 1));
                              if (!mounted) return;
                              Helper.makeToast(context,
                                  "The provided Email address or password are incorrect!");
                              return;
                            }
                            //if successful log in
                            else {
                              //navigate to home page
                              await Future.delayed(const Duration(seconds: 1));
                              if (!mounted) return;
                              Helper.pushPage(context, const HomeRoute());

                              //store token and userId
                              Map<String, dynamic> userMap =
                                  jsonDecode(res.body);
                              var token = Token.fromJson(userMap);

                              MyApp.jwtToken = token.token;
                              MyApp.userId = myEmailController.text.toString();

                              //fetch user roles
                              http.Response resp =
                                  await Helper.fetchUserRoles(token.token);
                              List<dynamic> list = json.decode(resp.body);
                              for (var element in list) {
                                MyApp.myRoles.add(Role.fromJson(element));
                              }

                              //TODO remove later greet user for log in
                              if (kDebugMode) {
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                if (!mounted) return;

                                var listRoles =
                                    MyApp.myRoles.map((e) => e.name);
                                if (listRoles.contains("admin")) {
                                  Helper.makeToast(context, "Welcome Admin!");
                                } else if (listRoles.contains("coach")) {
                                  Helper.makeToast(context, "Welcome Coach!");
                                } else {
                                  Helper.makeToast(context, "Welcome User!");
                                }
                              }
                            }
                          }
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        )),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
