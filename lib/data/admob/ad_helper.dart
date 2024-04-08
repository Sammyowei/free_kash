import 'dart:io';

extension AdExtention on String {
  String get testAds => 'ca-app-pub-3940256099942544/$this';
  String get prodAds => 'ca-app-pub-7368181546467398/$this';
}

class AdHelper {
  static String get rewardedAdsUnitTest =>
      Platform.isIOS ? '1712485313'.testAds : '5224354917'.testAds;

  static String get rewardedAdsUnitProd => "6137116988".prodAds;
}
