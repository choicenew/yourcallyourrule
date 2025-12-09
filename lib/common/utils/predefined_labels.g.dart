// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'predefined_labels.dart';

// **************************************************************************
// LabelGenerator
// **************************************************************************

extension LabelTranslationExtension on String {
  String translate(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    if (appLocalizations == null) return this;

    final normalizedLabel = toLowerCase().replaceAll(' ', '');

    switch (normalizedLabel) {
      case 'fraudscamlikely':
        return appLocalizations.fraudScamLikely;
      case 'spamlikely':
        return appLocalizations.spamLikely;
      case 'scamslikely':
        return appLocalizations.scamsLikely;
      case 'telemarketing':
        return appLocalizations.telemarketing;
      case 'robocall':
        return appLocalizations.robocall;
      case 'delivery':
        return appLocalizations.delivery;
      case 'takeaway':
        return appLocalizations.takeaway;
      case 'ridesharing':
        return appLocalizations.ridesharing;
      case 'insurance':
        return appLocalizations.insurance;
      case 'loan':
        return appLocalizations.loan;
      case 'customerservice':
        return appLocalizations.customerService;
      case 'unknown':
        return appLocalizations.unknown;
      case 'financial':
        return appLocalizations.financial;
      case 'bank':
        return appLocalizations.bank;
      case 'education':
        return appLocalizations.education;
      case 'medical':
        return appLocalizations.medical;
      case 'charity':
        return appLocalizations.charity;
      case 'other':
        return appLocalizations.other;
      case 'debtcollection':
        return appLocalizations.collection;
      case 'survey':
        return appLocalizations.survey;
      case 'political':
        return appLocalizations.political;
      case 'ecommerce':
        return appLocalizations.ecommerce;
      case 'risk':
        return appLocalizations.risk;
      case 'agent':
        return appLocalizations.agent;
      case 'recruiter':
        return appLocalizations.recruiter;
      case 'headhunter':
        return appLocalizations.headhunter;
      case 'silentcallvoiceclone':
        return appLocalizations.silentCallVoiceClone;
      case 'internet':
        return appLocalizations.internet;
      case 'travelticketing':
        return appLocalizations.travelTicketing;
      case 'applicationsoftware':
        return appLocalizations.applicationSoftware;
      case 'entertainment':
        return appLocalizations.entertainment;
      case 'government':
        return appLocalizations.government;
      case 'localservices':
        return appLocalizations.localServices;
      case 'automotiveindustry':
        return appLocalizations.automotiveIndustry;
      case 'carrental':
        return appLocalizations.carRental;
      case 'telecommunication':
        return appLocalizations.telecommunication;
      default:
        return this;
    }
  }
}
