import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ynv_donation_platform/firebase_options.dart';
import 'my_app.dart';
import 'screens/components/error_widget.dart';
import 'utils/app_perferences.dart';

// starting point of app
Future main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // mandatory when awaiting on main; must complete before accessing other resources
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
