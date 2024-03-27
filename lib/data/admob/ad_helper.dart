import 'dart:io';

class AdHelper {
  static String get rewardedAdsUnit => Platform.isIOS
      ? 'ca-app-pub-3940256099942544/1712485313'
      : 'ca-app-pub-3940256099942544/5224354917';
}
