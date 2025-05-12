// 电话标签仓库接口，定义电话号码与标签关联的数据操作方法

import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';


import 'base_repository.dart';

/// 电话标签仓库接口
/// 负责管理电话号码与标签ID的关联数据
abstract class LabelPhoneRepository extends BaseRepository<LabelPhoneEntry, String> {
  /// 根据名称获取标签
  Future<LabelPhoneEntry?> getByName(String name);
  
  /// 根据类型获取标签
  Future<List<LabelPhoneEntry>> getByType(String type);
  
  /// 检查标签名称是否已存在
  Future<bool> nameExists(String name);
  
  /// 获取所有启用的标签
  Future<List<LabelPhoneEntry>> getAllEnabled();
  
  /// 根据电话号码获取标签
  Future<LabelPhoneEntry?> getByPhoneNumber(String phoneNumber);
  
  /// 根据标签ID获取所有关联的电话标签
  Future<List<LabelPhoneEntry>> getByLabelId(String labelId);
}