// in ads_package/android/src/main/kotlin/.../AdsPackagePlugin.kt
package com.yours.ads_package

import android.content.Context
import android.view.LayoutInflater
import android.widget.Button
import android.widget.ImageView
import android.widget.RatingBar
import android.widget.TextView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin
import io.flutter.plugins.googlemobileads.NativeAdFactory

/**
 * AdsPackagePlugin
 * 
 * 提供 MethodChannel 让 Dart 侧在正确时机注册 NativeAdFactory
 */
class AdsPackagePlugin : FlutterPlugin, MethodCallHandler {
    
    private lateinit var channel: MethodChannel
    private lateinit var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding
    
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        flutterPluginBinding = binding
        channel = MethodChannel(binding.binaryMessenger, "ads_package")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "registerNativeAdFactories" -> {
                try {
                    // 注册全屏广告Factory
                    GoogleMobileAdsPlugin.registerNativeAdFactory(
                        flutterPluginBinding.flutterEngine,
                        "fullScreenAdFactory",
                        AdsNativeAdFactoryFullScreen(flutterPluginBinding.applicationContext)
                    )
                    
                    // 注册自适应卡片广告Factory
                    GoogleMobileAdsPlugin.registerNativeAdFactory(
                        flutterPluginBinding.flutterEngine,
                        "adaptiveCardAdFactory",
                        AdsNativeAdFactoryAdaptiveCard(flutterPluginBinding.applicationContext)
                    )
                    
                    result.success(true)
                } catch (e: Exception) {
                    result.error("REGISTRATION_ERROR", "Failed to register NativeAdFactory: ${e.message}", null)
                }
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}


/**
 * 全屏广告的 NativeAdFactory
 * 对应布局: native_ad_fullscreen.xml
 * 适用场景：PageView、TikTok 风格的全屏沉浸式广告
 */
class AdsNativeAdFactoryFullScreen(private val context: Context) : NativeAdFactory {
    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: Map<String, Any?>?
    ): NativeAdView {
        val adView = LayoutInflater.from(context)
            .inflate(R.layout.native_ad_fullscreen, null) as NativeAdView
        
        // 绑定 MediaView
        adView.mediaView = adView.findViewById(R.id.ad_media)
        adView.mediaView?.mediaContent = nativeAd.mediaContent
        
        // 绑定 Headline
        adView.headlineView = adView.findViewById(R.id.ad_headline)
        (adView.headlineView as? TextView)?.text = nativeAd.headline
        
        // 绑定 Body
        adView.bodyView = adView.findViewById(R.id.ad_body)
        (adView.bodyView as? TextView)?.text = nativeAd.body
        
        // 绑定 CTA Button
        adView.callToActionView = adView.findViewById(R.id.ad_call_to_action)
        (adView.callToActionView as? Button)?.text = nativeAd.callToAction
        
        // 绑定 App Icon
        adView.iconView = adView.findViewById(R.id.ad_app_icon)
        nativeAd.icon?.let {
            (adView.iconView as? ImageView)?.setImageDrawable(it.drawable)
        }
        
        // 绑定 Advertiser
        adView.advertiserView = adView.findViewById(R.id.ad_advertiser)
        (adView.advertiserView as? TextView)?.text = nativeAd.advertiser
        
        // 设置 NativeAd
        adView.setNativeAd(nativeAd)
        return adView
    }
}

/**
 * 自适应卡片广告的 NativeAdFactory
 * 对应布局: native_ad_adaptive_card.xml
 * 适用场景：ListView、GridView、瀑布流中的卡片式广告
 */
class AdsNativeAdFactoryAdaptiveCard(private val context: Context) : NativeAdFactory {
    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: Map<String, Any?>?
    ): NativeAdView {
        val adView = LayoutInflater.from(context)
            .inflate(R.layout.native_ad_adaptive_card, null) as NativeAdView
        
        // 绑定 MediaView
        adView.mediaView = adView.findViewById(R.id.ad_media)
        adView.mediaView?.mediaContent = nativeAd.mediaContent
        
        // 绑定 Headline
        adView.headlineView = adView.findViewById(R.id.ad_headline)
        (adView.headlineView as? TextView)?.text = nativeAd.headline
        
        // 绑定 Body
        adView.bodyView = adView.findViewById(R.id.ad_body)
        (adView.bodyView as? TextView)?.text = nativeAd.body
        
        // 绑定 CTA Button
        adView.callToActionView = adView.findViewById(R.id.ad_call_to_action)
        (adView.callToActionView as? Button)?.text = nativeAd.callToAction
        
        // 绑定 App Icon
        adView.iconView = adView.findViewById(R.id.ad_app_icon)
        nativeAd.icon?.let {
            (adView.iconView as? ImageView)?.setImageDrawable(it.drawable)
        }
        
        // 绑定 Star Rating
        adView.starRatingView = adView.findViewById(R.id.ad_stars)
        nativeAd.starRating?.let {
            (adView.starRatingView as? RatingBar)?.rating = it.toFloat()
        }
        
        // 绑定 Advertiser
        adView.advertiserView = adView.findViewById(R.id.ad_advertiser)
        (adView.advertiserView as? TextView)?.text = nativeAd.advertiser
        
        // 设置 NativeAd
        adView.setNativeAd(nativeAd)
        return adView
    }
}