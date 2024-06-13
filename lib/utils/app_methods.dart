import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_enums.dart';

// supported Locales list
List<Locale> supportedLocales =
    Language.values.map((element) => Locale(enumToString(element))).toList();

// Checking wheather value is null or empty.
bool isNullOrEmpty(dynamic value) {
  if (value == null) {
    return true;
  } else {
    if (value is List || value is String) {
      return value.isEmpty;
    } else {
      return value == '';
    }
  }
}

// print debug
printDebug(Object object) {
  if (kDebugMode) {
    print(object);
  }
}

// print log
printLog(String object) {
  if (kDebugMode) {
    log(object);
  }
}
