import 'package:flutter/foundation.dart';

bool isNotMobile() {

  return kIsWeb ||
      (defaultTargetPlatform != TargetPlatform.android &&
          defaultTargetPlatform != TargetPlatform.iOS);
/*
    if(kIsWeb) {
         return true;
     }

    return defaultTargetPlatform != TargetPlatform.android &&
        defaultTargetPlatform != TargetPlatform.iOS;
*/
}
/*
bool isMobileWeb () {

     final platform = defaultTargetPlatform;

     return platform == TargetPlatform.android ||
         platform == TargetPlatform.iOS;
}
*/