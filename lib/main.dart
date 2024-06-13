import 'dart:async';
import 'package:flutter/material.dart';
import 'my_app.dart';
import 'screens/components/error_widget.dart';
import 'utils/app_perferences.dart';

// starting point of app
Future main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // mandatory when awaiting on main; must complete before accessing other resources
  await UserPreferences.init(); // intializing shared prefrences
  //custom error widget on ==>>> flutter error
  ErrorWidget.builder = (details) {
    return ErrorUI(
      exception: details.exception,
    );
  };
  //root widget
  runApp(
    const MyApp(),
  );
}
