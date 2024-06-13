import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../provider/base/provider_response.dart';
import '../../utils/app_enums.dart';
import '../../utils/app_keys.dart';
import '../../utils/app_methods.dart';
import '../../utils/app_regex.dart';
import 'rest_client.dart';

// Api responses
class ApiServices extends RestClient {
  int? statusCode = -1;

  /// common interface for all api request
  Future<ProviderResponse> apiRequest(
    ApiRequestType request,
    ProviderEvent event,
    String apiEndPoint, {
    Map<String, dynamic>? body,
    Map<String, String>? addHeader,
    bool isCsv = false,
    ContentType contentType = ContentType.json,
    Map<String, dynamic>? queryParams,
    Duration? timeoutDuration,
  }) async {
    Uri uri = createURL(request, apiEndPoint, queryParams ?? {});
    Map<String, String> headers =
        await getHeaders(contentType, isCsv: isCsv, addHeader: addHeader);
    if (kDebugMode) {
      log('------------------------------------------');
      final startTime = DateTime.now();
      log('START TIME: ${startTime.hour} : ${startTime.minute} : ${startTime.second}');
      debugPrint('URL: $uri');
      debugPrint('METHOD: ${request.name}');
      debugPrint('HEADERS: $headers');
      debugPrint('BODY: $body');
    }

    // try api requests
    try {
      String responseBody;
      // multipart form-data request
      if (contentType == ContentType.formData) {
        http.StreamedResponse response =
            await formDataRequest(uri, request, headers, body!);
        statusCode = response.statusCode;

        List<String> dataList = await Future.wait(await response.stream
            .map((bytes) async =>
                await http.ByteStream.fromBytes(bytes).bytesToString())
            .toList());
        responseBody = '';
        for (var data in dataList) {
          responseBody += data;
        }
      } else {
        http.Response response;
        switch (request) {
          //GET-----
          case ApiRequestType.apiGet:
            response = await getRequest(uri, headers);
            break;
          //POST------
          case ApiRequestType.apiPost:
            response = await postRequest(uri, headers, body ?? {},
                timeoutDuration: timeoutDuration);
            break;
          //DELETE-----
          case ApiRequestType.apiDelete:
            response = await deleteRequest(uri, headers, body ?? {});
            break;
          //PATCH----
          case ApiRequestType.apiPatch:
            response = await patchRequest(uri, headers, body ?? {},
                timeoutDuration: timeoutDuration);
            break;
          //PUT------
          case ApiRequestType.apiPut:
            response = await putRequest(uri, headers, body ?? {},
                timeoutDuration: timeoutDuration);
            break;
          //FAILED-----
          default:
            return ProviderResponse(
              ProviderState.failed,
              event,
              message: 'Unknown API request received: $request',
            );
        }
        statusCode = response.statusCode;
        responseBody = response.body;
      }

      if (kDebugMode) {
        log('STATUS CODE: $statusCode $apiEndPoint');
        printDebug('RESPONSE: $responseBody');
      }

      var res = jsonDecode(responseBody);
      bool isSuccess = false;

      if (AppRegex.successCode.hasMatch('$statusCode')) {
        isSuccess = true;
      }

      if (isSuccess) {
        return ProviderResponse(
          ProviderState.success,
          event,
          data: res,
          statusCode: statusCode,
        );
      } else {
        return ProviderResponse(
          ProviderState.failed,
          event,
          message: res is String
              ? res
              : errorMessageStatus(statusCode!, res[ApiKeys.message]),
          data: res,
          statusCode: statusCode,
        );
      }
    } on SocketException {
      return ProviderResponse(
        ProviderState.noInternet,
        event,
        message: 'Please check your internet connection',
      );
    } on TimeoutException {
      return ProviderResponse(
        ProviderState.noInternet,
        event,
        message: 'Request timed out. Please try again later',
      );
    } catch (e) {
      return ProviderResponse(
        ProviderState.failed,
        event,
        message: errorMessageStatus(statusCode!, e.toString()),
        exceptionType: e.runtimeType,
      );
    } finally {
      if (kDebugMode) {
        final endTime = DateTime.now();
        debugPrint(
            'END TIME: $apiEndPoint ${endTime.hour} : ${endTime.minute} : ${endTime.second}');
        log('---------------------------------------');
      }
    }
  }

  String errorMessageStatus(int httpStatus, String error) {
    if (httpStatus >= 402 && httpStatus <= 499) {
      return "Down for maintenance\nWe’ll be back up soon!";
    }
    if (httpStatus >= 500) {
      return "Internal server error";
    }
    return error;
  }
}
