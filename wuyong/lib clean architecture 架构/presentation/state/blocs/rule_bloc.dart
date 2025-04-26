import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/usecases/rule/add_rule.dart';
import '../../../application/usecases/rule/delete_rule.dart';
import '../../../application/usecases/rule/update_rule.dart';
import '../../../application/usecases/rule/get_rules.dart';
import '../../../application/usecases/rule/match_rule.dart';
import '../../../application/usecases/rule/import_rules.dart';
import '../../../application/usecases/rule/export_rules.dart';
import '../../../domain/entities/rule/rule_base.dart';
import '../base/base_bloc.dart';

// 规则事件
abstract class RuleEvent extends BaseEvent {}

// 加载规则事件
class LoadRulesEvent extends RuleEvent {}

// 添加规则事件
class AddRuleEvent extends RuleEvent {
  final RuleBase rule;
  
  AddRuleEvent(this.rule);
}

// 更新规则事件
class UpdateRuleEvent extends RuleEvent {
  final RuleBase rule;
  
  UpdateRuleEvent(this.rule);
}

// 删除规则事件
class DeleteRuleEvent extends RuleEvent {
  final String ruleId;
  
  DeleteRuleEvent(this.ruleId);
}

// 匹配规则事件
class MatchRuleEvent extends RuleEvent {
  final String phoneNumber;
  
  MatchRuleEvent(this.phoneNumber);
}

// 导入规则事件
class ImportRulesEvent extends RuleEvent {
  final String filePath;
  
  ImportRulesEvent(this.filePath);
}

// 导出规则事件
class ExportRulesEvent extends RuleEvent {
  final String filePath;
  
  ExportRulesEvent(this.filePath);
}

// 规则状态
abstract class RuleState extends BaseState {}

// 规则加载成功状态
class RulesLoadedState extends LoadedState<List<RuleBase>> {
  RulesLoadedState(List<RuleBase> rules) : super(rules);
}

// 规则匹配成功状态
class RuleMatchedState extends LoadedState<RuleBase?> {
  RuleMatchedState(RuleBase? rule) : super(rule);
}

// 规则操作成功状态
class RuleOperationSuccessState extends BaseState {
  final String message;
  
  RuleOperationSuccessState(this.message);
}

/// 规则Bloc
/// 负责处理规则相关的事件和状态
class RuleBloc extends Bloc<RuleEvent, RuleState> {
  final AddRule _addRule;
  final DeleteRule _deleteRule;
  final UpdateRule _updateRule;
  final GetRules _getRules;
  final MatchRule _matchRule;
  final ImportRules _importRules;
  final ExportRules _exportRules;
  
  RuleBloc({
    required AddRule addRule,
    required DeleteRule deleteRule,
    required UpdateRule updateRule,
    required GetRules getRules,
    required MatchRule matchRule,
    required ImportRules importRules,
    required ExportRules exportRules,
  }) : _addRule = addRule,
       _deleteRule = deleteRule,
       _updateRule = updateRule,
       _getRules = getRules,
       _matchRule = matchRule,
       _importRules = importRules,
       _exportRules = exportRules,
       super(InitialState()) {
    on<LoadRulesEvent>(_onLoadRules);
    on<AddRuleEvent>(_onAddRule);
    on<UpdateRuleEvent>(_onUpdateRule);
    on<DeleteRuleEvent>(_onDeleteRule);
    on<MatchRuleEvent>(_onMatchRule);
    on<ImportRulesEvent>(_onImportRules);
    on<ExportRulesEvent>(_onExportRules);
  }
  
  // 处理加载规则事件
  Future<void> _onLoadRules(LoadRulesEvent event, Emitter<RuleState> emit) async {
    emit(LoadingState());
    
    try {
      final result = await _getRules.execute();
      result.fold(
        (failure) => emit(ErrorState(failure.message)),
        (rules) => emit(RulesLoadedState(rules)),
      );
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
  
  // 处理添加规则事件
  Future<void> _onAddRule(AddRuleEvent event, Emitter<RuleState> emit) async {
    emit(LoadingState());
    
    try {
      final result = await _addRule.execute(event.rule);
      result.fold(
        (failure) => emit(ErrorState(failure.message)),
        (_) {
          emit(RuleOperationSuccessState('规则添加成功'));
          add(LoadRulesEvent()); // 重新加载规则列表
        },
      );
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
  
  // 处理更新规则事件
  Future<void> _onUpdateRule(UpdateRuleEvent event, Emitter<RuleState> emit) async {
    emit(LoadingState());
    
    try {
      final result = await _updateRule.execute(event.rule);
      result.fold(
        (failure) => emit(ErrorState(failure.message)),
        (_) {
          emit(RuleOperationSuccessState('规则更新成功'));
          add(LoadRulesEvent()); // 重新加载规则列表
        },
      );
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
  
  // 处理删除规则事件
  Future<void> _onDeleteRule(DeleteRuleEvent event, Emitter<RuleState> emit) async {
    emit(LoadingState());
    
    try {
      final result = await _deleteRule.execute(event.ruleId);
      result.fold(
        (failure) => emit(ErrorState(failure.message)),
        (_) {
          emit(RuleOperationSuccessState('规则删除成功'));
          add(LoadRulesEvent()); // 重新加载规则列表
        },
      );
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
  
  // 处理匹配规则事件
  Future<void> _onMatchRule(MatchRuleEvent event, Emitter<RuleState> emit) async {
    emit(LoadingState());
    
    try {
      final result = await _matchRule.execute(event.phoneNumber);
      result.fold(
        (failure) => emit(ErrorState(failure.message)),
        (rule) => emit(RuleMatchedState(rule)),
      );
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
  
  // 处理导入规则事件
  Future<void> _onImportRules(ImportRulesEvent event, Emitter<RuleState> emit) async {
    emit(LoadingState());
    
    try {
      final result = await _importRules.execute(event.filePath);
      result.fold(
        (failure) => emit(ErrorState(failure.message)),
        (_) {
          emit(RuleOperationSuccessState('规则导入成功'));
          add(LoadRulesEvent()); // 重新加载规则列表
        },
      );
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
  
  // 处理导出规则事件
  Future<void> _onExportRules(ExportRulesEvent event, Emitter<RuleState> emit) async {
    emit(LoadingState());
    
    try {
      final result = await _exportRules.execute(event.filePath);
      result.fold(
        (failure) => emit(ErrorState(failure.message)),
        (_) => emit(RuleOperationSuccessState('规则导出成功')),
      );
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}