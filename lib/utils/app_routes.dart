import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ynv_donation_platform/screens/home/home.dart';
import 'app_keys.dart';
import 'app_route_names.dart';

// app routes
class AppRouter {
  static GoRouter goRouter = GoRouter(
    navigatorKey: WidgetKeys.navigatorKey,
    routes: [
      //onbaording--------------
      GoRoute(
        name: "initial",
        path: "/",
        builder: (context, state) => const SizedBox(),
        redirect: (context, state) async {
          return AppRoutes.home;
        },
      ),
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
