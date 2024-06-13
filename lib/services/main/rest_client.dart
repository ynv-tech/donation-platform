import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../utils/app_constants.dart';
import '../../utils/app_enums.dart';
import '../../utils/app_keys.dart';
import '../../utils/app_methods.dart';
import '../../utils/app_perferences.dart';
import '../../utils/global.dart';

class RestClient {
  /// get the base url acc. to running mode
  String get _baseUrl {
    switch (appBuildType) {
      case BuildType.dev:
        return AppBaseUrl.devBaseUrl;
      case BuildType.prod:
        return AppBaseUrl.productionBaseUrl;
      case BuildType.uat:
        return AppBaseUrl.releaseBaseUrl;
      default:
        return AppBaseUrl.devBaseUrl;
    }
  }

  /// convert the url string to URI
  /// appends query params to the url
  Uri createURL(
    ApiRequestType request,
    String apiEndPoint,
    Map<String, dynamic> queryParams,
  ) {
    String url;
    url = _baseUrl + apiEndPoint;

    // append query params to url
    if (request == ApiRequestType.apiGet) {
      int count = 0;
      queryParams.forEach((key, value) {
        if (count == 0) {
          url += '?';
        }
        url += '$key=$value';
        if (count < queryParams.length - 1) {
          url += '&';
        }
        count++;
      });
    }

    return Uri.parse(url);
  }

  /// to send get api request
  Future<http.Response> deleteRequest(
    Uri uri,
    Map<String, String> headersData,
    Map<String, dynamic> body,
  ) async {
    final client = http.Client();
    http.StreamedResponse response =
        await client.send(http.Request("DELETE", uri)
          ..headers.addAll(headersData)
          ..body = jsonEncode(body));
    return http.Response.fromStream(response).timeout(apiTimeOut);
  }

  /// to send form-data
  Future<http.StreamedResponse> formDataRequest(
    Uri uri,
    ApiRequestType method,
    Map<String, String> headers,
    Map<String, dynamic> body,
  ) async {
    Map<String, dynamic> formData = await _fileConversion(body);
    http.MultipartRequest request = http.MultipartRequest(
        (method == ApiRequestType.apiPost)
            ? ApiKeys.postMethod
            : ApiKeys.getMethod,
        uri)
      ..fields.addAll(formData[ApiKeys.fields])
      ..files.addAll(formData[ApiKeys.files])
      ..headers.addAll(headers);
    http.StreamedResponse res = await request.send().timeout(apiTimeOut);
    return res;
  }

  /// return basic or auth headers
  Future<Map<String, String>> getHeaders(ContentType contentType,
      {bool isCsv = false, Map<String, String>? addHeader}) async {
    printDebug("header of ouser is ${UserPreferences.accessToken}");
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      ApiKeys.contentType: (contentType == ContentType.json)
          ? ApiKeys.applicationJson
          : ApiKeys.formData,
      if (isCsv) ApiKeys.accept: 'text/csv',
      ApiKeys.accept: ApiKeys.applicationJson,
      ApiKeys.authorization: !isNullOrEmpty(UserPreferences.accessToken)
          ? "Bearer ${UserPreferences.accessToken}"
          : AppConstants.basicAuth,
      ApiKeys.platform: kIsWeb ? 'WEB' : Platform.operatingSystem.toUpperCase(),
      ApiKeys.timezone: DateTime.now().timeZoneOffset.inHours.toString(),
      ApiKeys.language: 'en',
      ApiKeys.apiKey: '1234',
    };

    if (addHeader != null && addHeader.isNotEmpty) {
      headers.addAll(addHeader);
    }

    return headers;
  }

  /// to send get api request
  Future<http.Response> getRequest(
    Uri uri,
    Map<String, String> headers,
  ) async {
    return await http.get(uri, headers: headers).timeout(apiTimeOut);
  }

  /// to send post api request
  Future<http.Response> patchRequest(
      Uri uri, Map<String, String> headers, Map<String, dynamic> body,
      {Duration? timeoutDuration}) async {
    return await http
        .patch(uri, headers: headers, body: json.encode(body))
        .timeout(timeoutDuration ?? apiTimeOut);
  }

  Future<http.Response> putRequest(
      Uri uri, Map<String, String> headers, Map<String, dynamic> body,
      {Duration? timeoutDuration}) async {
    return await http
        .put(uri, headers: headers, body: json.encode(body))
        .timeout(timeoutDuration ?? apiTimeOut);
  }

  /// to send post api request
  Future<http.Response> postRequest(
      Uri uri, Map<String, String> headers, Map<String, dynamic> body,
      {Duration? timeoutDuration}) async {
    return await http
        .post(uri, headers: headers, body: json.encode(body))
        .timeout(timeoutDuration ?? apiTimeOut);
  }

  /// to convert files to multipart-files for uploading
  Future<Map<String, dynamic>> _fileConversion(
    Map<String, dynamic> body,
  ) async {
    List<String> keysList = body.keys.toList();
    Map<String, String> fields = {};
    List<http.MultipartFile> files =
        List<http.MultipartFile>.empty(growable: true);

    for (var key in keysList) {
      if (body[key] is File) {
        files.add(await http.MultipartFile.fromPath(key, body[key].path));
      } else if (body[key] is List<File>) {
        for (var value in body[key]) {
          files.add(await http.MultipartFile.fromPath(key, value.path));
        }
      } else {
        fields[key] = body[key].toString();
      }
    }
    return {ApiKeys.fields: fields, ApiKeys.files: files};
  }
}
