import 'package:flutter/material.dart';
import 'package:free_kash/data/admob/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedVideoAds {
  const RewardedVideoAds();

  static RewardedAd? _rewardedAd;

  static var adsUnitId = AdHelper.rewardedAdsUnit;

  void loadAds() async {
    await RewardedAd.load(
      adUnitId: adsUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              loadAds();
            },
            onAdClicked: (ad) {
              debugPrint('ad has been clicked');
              dismiss();
              loadAds();
            },
            onAdDismissedFullScreenContent: (ad) {
              loadAds();
            },
            onAdImpression: (ad) {
              debugPrint('Impression Has been added');
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              loadAds();
            },
            onAdWillDismissFullScreenContent: (ad) {
              loadAds();
            },
          );

          debugPrint('Rewarded Ads Loaded Successfully ');
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (error) {
          debugPrint("Rewarded ads Failed to Load $error");
        },
      ),
    );
  }

  void dismiss() async {
    if (_rewardedAd != null) {
      await _rewardedAd!.dispose();
    }
  }

  void showAds() async {
    if (_rewardedAd != null) {
      await _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {},
      );
    }
  }
}
