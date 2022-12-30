import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';
import 'package:tiutiu/core/controllers/controllers.dart';
import 'package:tiutiu/core/local_storage/local_storage.dart';
import 'package:tiutiu/core/local_storage/local_storage_keys.dart';
import 'package:tiutiu/features/admob/constants/admob_block_names.dart';

final BannerAdListener _bannerAdlistener = BannerAdListener(
  // Called when an ad is successfully received.
  onAdLoaded: (Ad ad) => print('<> Ad loaded.'),
  // Called when an ad request failed.
  onAdFailedToLoad: (Ad ad, LoadAdError error) {
    // Dispose the ad here to free resources.
    ad.dispose();
    print('<> Ad failed to load: $error');
  },
  // Called when an ad opens an overlay that covers the screen.
  onAdOpened: (Ad ad) => print('<> Ad opened.'),
  // Called when an ad removes an overlay that covers the screen.
  onAdClosed: (Ad ad) => print('<> Ad closed.'),
  // Called when an impression occurs on the ad.
  onAdImpression: (Ad ad) => print('<> Ad impression.'),
);

class AdMobController extends GetxController {
  int minutesFreeOfRewarded = 2;
  bool _rewardedAdWasLoaded = false;

  final Rx<BannerAd> _bannerAd = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    listener: _bannerAdlistener,
    request: AdRequest(),
    size: AdSize.banner,
  ).obs;

  late RewardedAd _rewardedAd;

  BannerAd get bannerAd => _bannerAd.value;

  void updateBannerAdId(String adId) {
    bannerAd.dispose();

    _bannerAd(
      BannerAd(
        listener: _bannerAdlistener,
        request: AdRequest(),
        size: AdSize.banner,
        adUnitId: adId,
      ),
    );
  }

  Future<void> loadRewardedAd() async {
    await RewardedAd.load(
      adUnitId: appController.getAdMobBlockID(blockName: AdMobBlockName.whatsaAppNumber, type: AdMobType.rewarded),
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          this._rewardedAd = ad;
          _rewardedAdWasLoaded = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  Future<void> showRewardedAd() async {
    if (!_rewardedAdWasLoaded) {
      await loadRewardedAd();
    }

    _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) => print('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
    );

    _rewardedAd.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) async {
        ad.dispose();
        print('Usuário assistiu certinho ${ad.adUnitId} ${rewardItem.amount}');

        await LocalStorage.setValueUnderLocalStorageKey(
          key: LocalStorageKey.lastTimeWatchedARewarded,
          value: DateTime.now().toIso8601String(),
        );
      },
    );
  }

  void disposeAllAds() {
    bannerAd.dispose();
  }
}
