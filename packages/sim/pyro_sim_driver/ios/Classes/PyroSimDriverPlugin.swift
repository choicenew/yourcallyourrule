import Flutter
import UIKit
import CoreTelephony

public class PyroSimDriverPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
  private var eventSink: FlutterEventSink?
  private let changeNetworkInfo = CTTelephonyNetworkInfo()

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.yours.yourcallyourrule/sim", binaryMessenger: registrar.messenger())
    let instance = PyroSimDriverPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getActiveSimCards":
      getActiveSimCards(result: result)
    case "hasSimCard":
      hasSimCard(result: result)
    case "getNetworkInfo":
      getNetworkInfo(result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    eventSink = events
    changeNetworkInfo.serviceSubscriberCellularProvidersDidUpdateNotifier = { [weak self] _ in
      DispatchQueue.main.async { self?.eventSink?("sim") }
    }
    return nil
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    changeNetworkInfo.serviceSubscriberCellularProvidersDidUpdateNotifier = nil
    eventSink = nil
    return nil
  }

  private func getActiveSimCards(result: @escaping FlutterResult) {
    let telephonyInfo = CTTelephonyNetworkInfo()
    var simInfoList: [[String: Any?]] = []

    if #available(iOS 12.0, *) {
      if let carriers = telephonyInfo.serviceSubscriberCellularProviders {
        var slotIndex = 0
        for (_, carrier) in carriers {
          let simMap: [String: Any?] = [
            "subscriptionId": slotIndex,
            "simSlotIndex": slotIndex,
            "carrierName": carrier.carrierName ?? "",
            "displayName": carrier.carrierName ?? "SIM \(slotIndex + 1)",
            "countryIso": carrier.isoCountryCode?.uppercased() ?? "",
            "iccId": "",
            "mccString": carrier.mobileCountryCode ?? "",
            "mncString": carrier.mobileNetworkCode ?? "",
            "simPhoneNumber": "",
            "isDataRoaming": false,
            "isNetworkRoaming": false,
            "state": "ready"
          ]
          simInfoList.append(simMap)
          slotIndex += 1
        }
      }
    } else {
      if let carrier = telephonyInfo.subscriberCellularProvider {
        let simMap: [String: Any?] = [
          "subscriptionId": 0,
          "simSlotIndex": 0,
          "carrierName": carrier.carrierName ?? "",
          "displayName": carrier.carrierName ?? "SIM 1",
          "countryIso": carrier.isoCountryCode?.uppercased() ?? "",
          "iccId": "",
          "mccString": carrier.mobileCountryCode ?? "",
          "mncString": carrier.mobileNetworkCode ?? "",
          "simPhoneNumber": "",
          "isDataRoaming": false,
          "isNetworkRoaming": false,
          "state": "ready"
        ]
        simInfoList.append(simMap)
      }
    }

    result(simInfoList)
  }

  private func hasSimCard(result: @escaping FlutterResult) {
    let telephonyInfo = CTTelephonyNetworkInfo()
    if #available(iOS 12.0, *) {
      let hasSim = telephonyInfo.serviceSubscriberCellularProviders?.isEmpty == false
      result(hasSim)
    } else {
      let hasSim = telephonyInfo.subscriberCellularProvider != nil
      result(hasSim)
    }
  }

  private func getNetworkInfo(result: @escaping FlutterResult) {
    let telephonyInfo = CTTelephonyNetworkInfo()
    var networkOperatorName: String = ""
    var networkOperator: String = ""
    var networkType: String = "UNKNOWN"

    if #available(iOS 12.0, *) {
      if let carriers = telephonyInfo.serviceSubscriberCellularProviders,
         let firstCarrier = carriers.values.first {
        networkOperatorName = firstCarrier.carrierName ?? ""
        networkOperator = "\(firstCarrier.mobileCountryCode ?? "")\(firstCarrier.mobileNetworkCode ?? "")"
      }
      if let radioTypes = telephonyInfo.serviceCurrentRadioAccessTechnology,
         let firstRadioType = radioTypes.values.first {
        networkType = mapRadioAccessTechnology(firstRadioType)
      }
    } else {
      if let carrier = telephonyInfo.subscriberCellularProvider {
        networkOperatorName = carrier.carrierName ?? ""
        networkOperator = "\(carrier.mobileCountryCode ?? "")\(carrier.mobileNetworkCode ?? "")"
      }
      if let radioType = telephonyInfo.currentRadioAccessTechnology {
        networkType = mapRadioAccessTechnology(radioType)
      }
    }

    let networkInfo: [String: Any?] = [
      "networkOperatorName": networkOperatorName,
      "networkOperator": networkOperator,
      "networkType": networkType,
      "isNetworkAvailable": !networkOperator.isEmpty,
      "isRoaming": false
    ]

    result(networkInfo)
  }

  private func mapRadioAccessTechnology(_ technology: String) -> String {
    switch technology {
    case CTRadioAccessTechnologyGPRS:
      return "GPRS"
    case CTRadioAccessTechnologyEdge:
      return "EDGE"
    case CTRadioAccessTechnologyWCDMA:
      return "UMTS"
    case CTRadioAccessTechnologyHSDPA:
      return "HSDPA"
    case CTRadioAccessTechnologyHSUPA:
      return "HSUPA"
    case CTRadioAccessTechnologyLTE:
      return "LTE"
    default:
      if #available(iOS 14.1, *) {
        if technology == CTRadioAccessTechnologyNR || technology == CTRadioAccessTechnologyNRNSA {
          return "5G"
        }
      }
      return "UNKNOWN"
    }
  }
}
