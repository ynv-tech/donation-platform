import 'package:flutter/material.dart';

abstract class AppBaseUrl {
  // Development
  static String devBaseUrl = "";

  // uat
  static String releaseBaseUrl = "";

  // prod
  static String productionBaseUrl = "";
}

abstract class ApiKeys {
  // REQUEST keys
  static const String fields = 'fields';
  static const String files = 'files';
  // Headers
  static const String platform = 'platform';
  static const String timezone = 'timezone';
  static const String language = 'language';
  static const String apiKey = 'api_key';
  // HEADER keys
  static const String getMethod = 'GET';
  static const String postMethod = 'POST';
  static const String putMethod = 'PUT';
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String formData = 'multipart/form-data';
  static const String authorization = 'Authorization';
  static const String userAgent = 'User-Agent';
  static const String accept = 'accept';
  static const String message = 'message';
  static const String isFromMyNotes = 'isFromMyNotes';
  static const String myNotes = 'myNotes';
}

abstract class ModelKeys {}

abstract class WidgetKeys {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(
          debugLabel: 'YnvDontationPlatformMainNavigatorKey');
  static final globalKey =
      GlobalKey<ScaffoldMessengerState>(); // Scaffold Messenger key
}
