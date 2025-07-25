import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 标签翻译工具类
/// 用于将预定义标签翻译为本地化字符串
class LabelTranslationUtils {
  /// 翻译预定义标签
  static String translatePredefinedLabel(String label, BuildContext context) {
    // 诈骗相关标签
    if (label.contains('Fraud Scam Likely')) {
      return AppLocalizations.of(context)!.fraudScamLikely;
    } else if (label.contains('Spam Likely')) {
      return AppLocalizations.of(context)!.spamLikely;
    } else if (label.contains('Scams Likely')) {
      return AppLocalizations.of(context)!.scamsLikely;
    }
    
    // 其他常见标签
    switch (label) {
      case 'Telemarketing':
        return AppLocalizations.of(context)!.telemarketing;
      case 'Robocall':
        return AppLocalizations.of(context)!.robocall;
      case 'Delivery':
        return AppLocalizations.of(context)!.delivery;
      case 'Takeaway':
        return AppLocalizations.of(context)!.takeaway;
      case 'Ridesharing':
        return AppLocalizations.of(context)!.ridesharing;
      case 'Insurance':
        return AppLocalizations.of(context)!.insurance;
      case 'Loan':
        return AppLocalizations.of(context)!.loan;
      case 'Customer Service':
        return AppLocalizations.of(context)!.customerService;
      case 'Unknown':
        return AppLocalizations.of(context)!.unknown;
      case 'Financial':
        return AppLocalizations.of(context)!.financial;
      case 'Bank':
        return AppLocalizations.of(context)!.bank;
      case 'Education':
        return AppLocalizations.of(context)!.education;
      case 'Medical':
        return AppLocalizations.of(context)!.medical;
      case 'Charity':
        return AppLocalizations.of(context)!.charity;
      case 'Other':
        return AppLocalizations.of(context)!.other;
      case 'Debt Collection':
        return AppLocalizations.of(context)!.debtCollection;
      case 'Survey':
        return AppLocalizations.of(context)!.survey;
      case 'Political':
        return AppLocalizations.of(context)!.political;
      case 'Ecommerce':
        return AppLocalizations.of(context)!.ecommerce;
      case 'Risk':
        return AppLocalizations.of(context)!.risk;
      case 'Agent':
        return AppLocalizations.of(context)!.agent;
      case 'Recruiter':
        return AppLocalizations.of(context)!.recruiter;
      case 'Headhunter':
        return AppLocalizations.of(context)!.headhunter;
      case 'Silent Call Voice Clone':
        return AppLocalizations.of(context)!.silentCallVoiceClone;
      case 'Internet':
        return AppLocalizations.of(context)!.internet;
      case 'Travel Ticketing':
        return AppLocalizations.of(context)!.travelTicketing;
      case 'Application Software':
        return AppLocalizations.of(context)!.applicationSoftware;
      case 'Entertainment':
        return AppLocalizations.of(context)!.entertainment;
      case 'Government':
        return AppLocalizations.of(context)!.government;
      case 'Local Services':
        return AppLocalizations.of(context)!.localServices;
      case 'Automotive Industry':
        return AppLocalizations.of(context)!.automotiveIndustry;
      case 'Car Rental':
        return AppLocalizations.of(context)!.carRental;
      case 'Telecommunication':
        return AppLocalizations.of(context)!.telecommunication;
      default:
        return label; // 如果没有对应的翻译，返回原始标签
    }
  }
}