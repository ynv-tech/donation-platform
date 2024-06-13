import 'package:flutter/material.dart';

import '../../utils/app_keys.dart';
import '../../utils/app_methods.dart';
import 'global_provider.dart';
import 'provider_consumer.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_theme.dart';

//Provider Consumer class
class ProviderWrapper extends StatelessWidget {
  const ProviderWrapper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //provider consumer
    return ProviderConsumer<GlobalProvider>(
      //default view with Material App
      defaultView: (context, provider, child) => MaterialApp.router(
        scaffoldMessengerKey: WidgetKeys.globalKey,
        supportedLocales: supportedLocales,
        // locale: DevicePreview.locale(context),
        debugShowCheckedModeBanner: false,
        // title: AppStrings.appName,
        theme: AppTheme().lightTheme(),
        routerConfig: AppRouter.goRouter,
      ),
    );
  }
}
