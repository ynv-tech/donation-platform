
import 'package:provider/provider.dart';

import 'global_provider.dart';

class MultiProvidersList {
  //list of all the global providers
  listOfProviders() {
    return [
      //global provider
      ChangeNotifierProvider<GlobalProvider>(
        create: (context) => GlobalProvider(),
      ),
      //Terms Of Use Provider

     
    ];
  }
}
