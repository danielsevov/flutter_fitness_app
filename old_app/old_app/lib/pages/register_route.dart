import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:first_solo_flutter_app/helper.dart';

//home page hub
class RegisterRoute extends StatefulWidget {
  const RegisterRoute({super.key, required this.userId});

  final String userId;

  @override
  _RegisterRouteState createState() => _RegisterRouteState(userId);
}

class _RegisterRouteState extends State<RegisterRoute> {
  final String userId;
  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  _RegisterRouteState(this.userId);

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.redColor,
        centerTitle: true,
        title: const Text("Registration"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<void>(
              future:
                  _initialize(), // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                Widget children;
                if (snapshot.connectionState != ConnectionState.done) {
                  children = Column(children: const [
                    SizedBox(
                      height: 200,
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Loading data...'),
                    ),
                  ]);
                } else {
                  children = Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Helper.redColor,
                        child: IconButton(onPressed: () {

                        }, icon: const Icon(Icons.send, color: Colors.white,)),
                      )
                    ],
                  );
                }
                return Center(
                  child: children,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> _initialize() {
    return Future.delayed(const Duration(seconds: 1));
  }
}