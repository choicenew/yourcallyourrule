
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';


class CallData {
  final CallerIdData callerIdData;
  final String e164Number;
  final String nationalNumber;
  final StirInfo? stirInfo;
  final SimInfo? simInfo;

  CallData({
    required this.callerIdData,
    required this.e164Number,
    required this.nationalNumber,
    this.stirInfo,
    this.simInfo,
  });

  factory CallData.fromMap(Map<String, dynamic> map) {
    return CallData(
      callerIdData: CallerIdData.fromMap(map['callerIdData']),
      e164Number: map['e164Number'],
      nationalNumber: map['nationalNumber'],
      stirInfo: map['stirInfo'] != null ? StirInfo.fromMap(map['stirInfo']) : null,
      simInfo: map['simInfo'] != null ? SimInfo.fromMap(map['simInfo']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'callerIdData': callerIdData.toMap(),
      'e164Number': e164Number,
      'nationalNumber': nationalNumber,
      'stirInfo': stirInfo?.toMap(),
      'simInfo': simInfo?.toMap(),
    };
  }

  CallData copyWith({
    CallerIdData? callerIdData,
    String? e164Number,
    String? nationalNumber,
    StirInfo? stirInfo,
    SimInfo? simInfo,
  }) {
    return CallData(
      callerIdData: callerIdData ?? this.callerIdData,
      e164Number: e164Number ?? this.e164Number,
      nationalNumber: nationalNumber ?? this.nationalNumber,
      stirInfo: stirInfo ?? this.stirInfo,
      simInfo: simInfo ?? this.simInfo,
    );
  }
}