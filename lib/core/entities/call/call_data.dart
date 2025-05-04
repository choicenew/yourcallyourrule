
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
}