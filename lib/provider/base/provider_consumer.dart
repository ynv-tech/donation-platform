import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_enums.dart';
import 'provider_base.dart';

// provider consumer class
class ProviderConsumer<T extends ProviderBase> extends StatelessWidget {
  // views to display on different states
  final Widget Function(BuildContext, T, Widget)? defaultView;
  final Widget Function(BuildContext, T, Widget)? loadingView;
  final Widget Function(BuildContext, T, Widget)? noInternetView;
  final Widget Function(BuildContext, T, Widget)? successView;
  final Widget Function(BuildContext, T, Widget)? failedView;
  final Widget? child;

  // callback functions for different states
  final Function(BuildContext, T)? onLoading;
  final Function(BuildContext, T)? onNoInternet;
  final Function(BuildContext, T)? onSuccess;
  final Function(BuildContext, T)? onFailed;

  const ProviderConsumer({
    super.key,
    required this.defaultView,
    this.child,
    this.loadingView,
    this.noInternetView,
    this.successView,
    this.failedView,
    this.onLoading,
    this.onNoInternet,
    this.onSuccess,
    this.onFailed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, t, _) {
        _onCallbacks(context, t);
        switch (t.state) {
          //loading
          case ProviderState.loading:
            return (loadingView == null)
                ? defaultView!(context, t, child ?? const SizedBox.shrink())
                : loadingView!(context, t, child ?? const SizedBox.shrink());
          //no internet
          case ProviderState.noInternet:
            return (noInternetView == null)
                ? defaultView!(context, t, child ?? const SizedBox.shrink())
                : noInternetView!(context, t, child ?? const SizedBox.shrink());
          //success
          case ProviderState.success:
            return (successView == null)
                ? defaultView!(context, t, child ?? const SizedBox.shrink())
                : successView!(context, t, child ?? const SizedBox.shrink());
          //failed
          case ProviderState.failed:
            return (failedView == null)
                ? defaultView!(context, t, child ?? const SizedBox.shrink())
                : failedView!(context, t, child ?? const SizedBox.shrink());
          //default view
          default:
            return defaultView!(context, t, child ?? const SizedBox.shrink());
        }
      },
      child: child ?? const SizedBox.shrink(),
    );
  }

  void _onCallbacks(BuildContext context, T t) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (t.previousState == t.state && t.previousEvent == t.previousEvent) {
        return;
      }
      switch (t.state) {
        case ProviderState.loading:
          if (onLoading != null) onLoading!(context, t); //widget callback
          t.onLoad(); //provider class callback
          break;
        case ProviderState.noInternet:
          if (onNoInternet != null) onNoInternet!(context, t); //widget callback
          t.onNoInternet(); //provider class callback
          break;
        case ProviderState.success:
          if (onSuccess != null) onSuccess!(context, t); //widget callback
          t.onSuccess(); //provider class callback
          break;
        case ProviderState.failed:
          if (onFailed != null) onFailed!(context, t); //widget callback
          t.onFailed(); //provider class callback
          break;
        default:
      }
      t.onCallbackComplete();
    });
  }
}
