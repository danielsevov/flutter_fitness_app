import 'package:flutter/material.dart';
import 'helper.dart';
import 'presentation/state_management/app_state.dart';
import 'presentation/ui/pages/log_in_page.dart';
import 'package:provider/provider.dart';

/// The main file of the application.
void main() {
  runApp(const MyApp());
}

/// The application object.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// This build method creates the widget, which is the root of the application.
  @override
  Widget build(BuildContext context) {
    // set the AppState provider in the root of the widget tree, so all widgets can access it.
    return Provider<AppState>(
        create: (_) => AppState(),
        child: MaterialApp(

            //set the title of the app
            title: 'LiftToLiveApp',

            //set the primary color of the app
            theme: ThemeData(
              backgroundColor: Helper.pageBackgroundColor,
              canvasColor: Helper.blueColor
            ),

            // set the entry page to be log in page
            home: const LogInPage()));
  }
}
