import 'package:flutter/foundation.dart';

bool isNotMobile() {

    if(kIsWeb) {
         return !isMobileWeb();
     }

    return defaultTargetPlatform != TargetPlatform.android &&
        defaultTargetPlatform != TargetPlatform.iOS;

}

bool isMobileWeb () {

     final platform = defaultTargetPlatform;

     return platform == TargetPlatform.android ||
         platform == TargetPlatform.iOS;
}
