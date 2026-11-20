import Flutter
import UIKit
import google_mobile_ads

public class AdsPackagePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let factoryFull = NativeAdFactory(xibName: "NativeAdFullscreen")
    FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
        registrar, factoryId: "fullScreenAdFactory", nativeAdFactory: factoryFull)
        
    let factoryCard = NativeAdFactory(xibName: "NativeAdAdaptiveCard")
    FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
        registrar, factoryId: "adaptiveCardAdFactory", nativeAdFactory: factoryCard)
  }
}

class NativeAdFactory: FLTNativeAdFactory {
    let xibName: String

    init(xibName: String) {
        self.xibName = xibName
    }

    func createNativeAd(_ nativeAd: GADNativeAd,
                        customOptions: [AnyHashable : Any]? = nil) -> GADNativeAdView? {
        // Load nib from the plugin bundle, not main bundle
        let bundle = Bundle(for: AdsPackagePlugin.self)
        let nibViews = bundle.loadNibNamed(xibName, owner: nil, options: nil)
        let adView = nibViews?.first as! GADNativeAdView

        // Populate the ad view with the ad assets
        adView.nativeAd = nativeAd
        (adView.headlineView as? UILabel)?.text = nativeAd.headline
        // Map other assets here...

        return adView
    }
}
