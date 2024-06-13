// ignore_for_file: empty_catches

import 'package:flutter/material.dart';

import '../../utils/app_enums.dart';
import 'provider_response.dart';

/// base class for all the change notifiers
class ProviderBase with ChangeNotifier {
  ProviderResponse? _providerResponse;
  ProviderResponse? _previousResponse;

  ///get the response data
  get data => _providerResponse?.data;

  /// get the api event
  ProviderEvent get event => _providerResponse?.event ?? ProviderEvent.none;

  ///get the message of the api response
  String get message => _providerResponse?.message ?? '';

  ///get the previous response data
  get previousData => _previousResponse?.data;

  /// get the previous event of the api response
  ProviderEvent get previousEvent =>
      _previousResponse?.event ?? ProviderEvent.none;

  ///get the previous message of the api response
  String get previousMessage => _previousResponse?.message ?? '';

  /// get the previous api response
  ProviderResponse get previousResponse => _previousResponse!;

  /// get the previous state of the api response
  ProviderState get previousState =>
      _previousResponse?.state ?? ProviderState.none;

  ///get the previous status code of the api response
  int get previousStatusCode => _previousResponse!.statusCode!;

  /// get the complete api response
  ProviderResponse get response => _providerResponse!;

  /// get the current state of the api response
  ProviderState get state => _providerResponse?.state ?? ProviderState.none;

  ///get the status code of the api response
  int get statusCode => _providerResponse!.statusCode!;

  /// change the state and notify the consumer
  void changeState(ProviderResponse response) {
    //if previous and new states are same, don't rebuild the consumer
    if (_providerResponse?.state == response.state &&
        _providerResponse?.event == response.event) return;
    _previousResponse = _providerResponse;
    _providerResponse = response;
    //exception may arise if provider is disposed before notifying
    try {
      notifyListeners();
    } catch (e) {}
  }

  /// on callback complete, set previous state to current state
  void onCallbackComplete() {
    _previousResponse = _providerResponse;
  }

  ///called when api state changes to failed
  void onFailed() {}

  ///called when api state changes to loading
  void onLoad() {}

  ///called when api state changes to no-internet
  void onNoInternet() {}

  ///called when api state changes to success
  void onSuccess() {}
}
