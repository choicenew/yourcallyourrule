import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/sms/repositories/sms_regex_rule_repository.dart';
import 'package:yourcallyourrule/features/sms/data/datasources/local_sms_regex_rule_datasource.dart';

part 'sms_regex_rule_repository_impl.g.dart';

@Riverpod(keepAlive: true)
SmsRegexRuleRepository smsRegexRuleRepository(Ref ref) {
  final dataSource = ref.watch(localSmsRegexRuleDataSourceProvider);
  return SmsRegexRuleRepository(dataSource);
}
