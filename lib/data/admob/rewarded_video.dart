// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import 'package:free_kash/data/auth/auth.dart';
import 'package:free_kash/data/db/_db_config.dart';
import 'package:free_kash/data/models/user/user.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:uuid/uuid.dart';

import '../data.dart';

class RewardedVideoAds {
  RewardedVideoAds({required this.user});

  final User user;
  static RewardedAd? _rewardedAd;

  static var adsUnitId = AdHelper.rewardedAdsUnitTest;

  double _rewardPoint = 0;
  bool _isAdClicked = false;

  void loadAds(BuildContext context) async {
    await RewardedAd.load(
      adUnitId: adsUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              loadAds(context);
              _isAdClicked = false;
            },
            onAdClicked: (ad) async {
              debugPrint('ad has been clicked');
              loadAds(context);

              _isAdClicked = true;

              if (_isAdClicked == true) {
                if (_rewardPoint != 0) {
                  var newReward = _rewardPoint * 2;

                  final reward = Reward(
                    amount: newReward,
                    createdAt: DateTime.now(),
                    description: 'Ads clicked earning.',
                    uuid: const Uuid().v1(),
                  );

                  user.addRewardToHistory(reward);

                  user.addReward(newReward);

                  final id = AuthClient().userID;

                  final DbConfig config = DbConfig(dbStore: 'users');

                  await config.update(
                    user.toJson(),
                    id,
                  );
                }
              }
            },
            onAdDismissedFullScreenContent: (ad) {
              loadAds(context);
              _isAdClicked = false;
            },
            onAdImpression: (ad) {
              debugPrint('Impression Has been added');
              _isAdClicked = false;
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              loadAds(context);
              _isAdClicked = false;
            },
            onAdWillDismissFullScreenContent: (ad) {
              loadAds(context);
              _isAdClicked = false;
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
        onUserEarnedReward: (ad, reward) async {
          _rewardPoint = double.parse(reward.amount.toString());

          if (_rewardPoint != 0) {
            final _reward = Reward(
              amount: _rewardPoint,
              createdAt: DateTime.now(),
              description: 'Ads Watched earning.',
              uuid: const Uuid().v1(),
            );

            user.addReward(_rewardPoint);

            user.addRewardToHistory(_reward);

            final config = DbConfig(dbStore: 'users');

            await config.update(user.toJson(), AuthClient().userID);
          }
        },
      );
    }
  }
}
