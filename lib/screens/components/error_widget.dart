import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';

// custom error widget on flutter error red screen
class ErrorUI extends StatelessWidget {
  final dynamic exception;
  const ErrorUI({super.key, this.exception});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Error\n$exception',
        style: AppStyle.helvetica700White,
        textAlign: TextAlign.center,
      ),
    );
  }
}
