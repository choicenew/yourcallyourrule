import 'package:flutter/material.dart';
import 'package:yourcallyourrule/common/utils/label_annotations.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

part 'predefined_labels.g.dart';

/// 预定义标签列表
/// 用于初始化系统中的标准标签
@AppLabel()
const List<Map<String, dynamic>> predefinedLabels = [
  {'text': 'Fraud Scam Likely'},
  {'text': 'Spam Likely'},
  {'text': 'Scams Likely'},
  {'text': 'Telemarketing'},
  {'text': 'Robocall'},
  {'text': 'Delivery'},
  {'text': 'Takeaway'},
  {'text': 'Ridesharing'},
  {'text': 'Insurance'},
  {'text': 'Loan'},
  {'text': 'Customer Service'},
  {'text': 'Unknown'},
  {'text': 'Financial'},
  {'text': 'Bank'},
  {'text': 'Education'},
  {'text': 'Medical'},
  {'text': 'Charity'},
  {'text': 'Other'},
  {'text': 'Debt Collection', 'key': 'collection'},
  {'text': 'Survey'},
  {'text': 'Political'},
  {'text': 'Ecommerce'},
  {'text': 'Risk'},
  {'text': 'Agent'},
  {'text': 'Recruiter'},
  {'text': 'Headhunter'},
  {'text': 'Silent Call Voice Clone'},
  {'text': 'Internet'},
  {'text': 'Travel Ticketing'},
  {'text': 'Application Software'},
  {'text': 'Entertainment'},
  {'text': 'Government'},
  {'text': 'Local Services'},
  {'text': 'Automotive Industry'},
  {'text': 'Car Rental'},
  {'text': 'Telecommunication'},
];
