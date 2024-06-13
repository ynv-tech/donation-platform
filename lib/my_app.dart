import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/base/multi_providers.dart';
import 'provider/base/provider_wrapper.dart';

//first screen after main
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    //multi provider
    return MultiProvider(
      //list of providers
      providers: MultiProvidersList().listOfProviders(),
      //provider wrapper
      child: const ProviderWrapper(),
    );
  }
}
