import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  //Push a named route onto the page stack w/ optional parameters,
  pushNamed(BuildContext context, routeName) {
    return GoRouter.of(context).pushNamed(routeName);
  }

  //Replaces the top-most page of the page stack with the given URL location w/ optional query parameters.
  pushReplacement(BuildContext context, routeName) {
    return GoRouter.of(context).pushReplacement(routeName);
  }

  //Navigate to a named route w/ optional parameters.
  goNamed(BuildContext context, routeName) {
    return GoRouter.of(context).goNamed(routeName);
  }

  //Pop the top-most route off the current screen.
  pop(BuildContext context) {
    return GoRouter.of(context).pop();
  }
}
