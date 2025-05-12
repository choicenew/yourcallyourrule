import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';
import 'package:yourcallyourrule/features/rules/services/blacklist_whitelist_service.dart';
import 'package:yourcallyourrule/features/rules/services/regex_service.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

/// 规则导入导出页面
class RuleImportExportPage extends StatefulWidget {
  const RuleImportExportPage({Key? key}) : super(key: key);

  @override
  State<RuleImportExportPage> createState() => _RuleImportExportPageState();
}

class _RuleImportExportPageState extends State<RuleImportExportPage> {
  bool _isExporting = false;
  bool _isImporting = false;
  String? _selectedRuleType;
  String? _selectedFileFormat;
  
  final List<String> _ruleTypes = [
    '白名单规则',
    '黑名单规则',
    '允许规则',
    '阻止规则',
    '正则规则',
    '所有规则'
  ];
  
  final List<String> _fileFormats = [
    'JSON',
    'CSV',
    'YAML'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('规则导入导出'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 信息卡片
            Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '规则导入导出',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '您可以导出规则以备份，或者导入之前备份的规则。支持JSON、CSV和YAML格式。',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            
            // 规则类型选择
            const Text(
              '选择规则类型',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedRuleType,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              hint: const Text('请选择规则类型'),
              items: _ruleTypes.map((type) => DropdownMenuItem(
                value: type,
                child: Text(type),
              )).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRuleType = value;
                });
              },
            ),
            
            const SizedBox(height: 24),
            
            // 文件格式选择
            const Text(
              '选择文件格式',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedFileFormat,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              hint: const Text('请选择文件格式'),
              items: _fileFormats.map((format) => DropdownMenuItem(
                value: format,
                child: Text(format),
              )).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedFileFormat = value;
                });
              },
            ),
            
            const SizedBox(height: 32),
            
            // 导入导出按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.file_upload),
                  label: Text(_isImporting ? '导入中...' : '导入规则'),
                  onPressed: (_isImporting || _selectedRuleType == null || _selectedFileFormat == null)
                      ? null
                      : _importRules,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.file_download),
                  label: Text(_isExporting ? '导出中...' : '导出规则'),
                  onPressed: (_isExporting || _selectedRuleType == null || _selectedFileFormat == null)
                      ? null
                      : _exportRules,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportRules() async {
    if (_selectedRuleType == null || _selectedFileFormat == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('请选择规则类型和文件格式'),
        backgroundColor: Colors.red,
      ));
      return;
    }
    
    setState(() {
      _isExporting = true;
    });
    
    try {
      // 获取文件扩展名
      String extension;
      switch (_selectedFileFormat) {
        case 'JSON':
          extension = 'json';
          break;
        case 'CSV':
          extension = 'csv';
          break;
        case 'YAML':
          extension = 'yaml';
          break;
        default:
          extension = 'json';
      }
      
      // 获取文件名
      String fileName;
      switch (_selectedRuleType) {
        case '白名单规则':
          fileName = 'whitelist_rules';
          break;
        case '黑名单规则':
          fileName = 'blacklist_rules';
          break;
        case '允许规则':
          fileName = 'allowed_rules';
          break;
        case '阻止规则':
          fileName = 'blocked_rules';
          break;
        case '正则规则':
          fileName = 'regex_rules';
          break;
        case '所有规则':
          fileName = 'all_rules';
          break;
        default:
          fileName = 'rules';
      }
      
      // 选择保存位置
      final result = await FilePicker.platform.saveFile(
        dialogTitle: '导出${_selectedRuleType}',
        fileName: '${fileName}.${extension}',
      );
      
      if (result != null) {
        // 根据规则类型选择对应的服务
        switch (_selectedRuleType) {
          case '白名单规则':
            final service = Provider.of<BlacklistWhitelistService>(context, listen: false);
            await service.exportWhitelistRules(result, _getFormatType());
            break;
          case '黑名单规则':
            final service = Provider.of<BlacklistWhitelistService>(context, listen: false);
            await service.exportBlacklistRules(result, _getFormatType());
            break;
          case '允许规则':
            final service = Provider.of<AllowedBlockedService>(context, listen: false);
            await service.exportAllowedRules(result, _getFormatType());
            break;
          case '阻止规则':
            final service = Provider.of<AllowedBlockedService>(context, listen: false);
            await service.exportBlockedRules(result, _getFormatType());
            break;
          case '正则规则':
            final service = Provider.of<RegexService>(context, listen: false);
            await service.exportRegexRules(result, _getFormatType());
            break;
          case '所有规则':
            final service = Provider.of<RuleImportExportService>(context, listen: false);
            await service.exportAllRules(result, _getFormatType());
            break;
        }
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${_selectedRuleType}导出成功'),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('导出失败: $e'),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        _isExporting = false;
      });
    }
  }

  Future<void> _importRules() async {
    if (_selectedRuleType == null || _selectedFileFormat == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('请选择规则类型和文件格式'),
        backgroundColor: Colors.red,
      ));
      return;
    }
    
    setState(() {
      _isImporting = true;
    });
    
    try {
      // 获取文件扩展名
      List<String> allowedExtensions;
      switch (_selectedFileFormat) {
        case 'JSON':
          allowedExtensions = ['json'];
          break;
        case 'CSV':
          allowedExtensions = ['csv'];
          break;
        case 'YAML':
          allowedExtensions = ['yaml', 'yml'];
          break;
        default:
          allowedExtensions = ['json', 'csv', 'yaml', 'yml'];
      }
      
      // 选择文件
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: '导入${_selectedRuleType}',
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
      );
      
      if (result != null && result.files.single.path != null) {
        // 根据规则类型选择对应的服务
        int importedCount = 0;
        switch (_selectedRuleType) {
          case '白名单规则':
            final service = Provider.of<BlacklistWhitelistService>(context, listen: false);
            importedCount = await service.importWhitelistRules(result.files.single.path!, _getFormatType());
            break;
          case '黑名单规则':
            final service = Provider.of<BlacklistWhitelistService>(context, listen: false);
            importedCount = await service.importBlacklistRules(result.files.single.path!, _getFormatType());
            break;
          case '允许规则':
            final service = Provider.of<AllowedBlockedService>(context, listen: false);
            importedCount = await service.importAllowedRules(result.files.single.path!, _getFormatType());
            break;
          case '阻止规则':
            final service = Provider.of<AllowedBlockedService>(context, listen: false);
            importedCount = await service.importBlockedRules(result.files.single.path!, _getFormatType());
            break;
          case '正则规则':
            final service = Provider.of<RegexService>(context, listen: false);
            importedCount = await service.importRegexRules(result.files.single.path!, _getFormatType());
            break;
          case '所有规则':
            final service = Provider.of<RuleImportExportService>(context, listen: false);
            importedCount = await service.importAllRules(result.files.single.path!, _getFormatType());
            break;
        }
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('成功导入 $importedCount 条${_selectedRuleType}'),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('导入失败: $e'),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        _isImporting = false;
      });
    }
  }

  String _getFormatType() {
    switch (_selectedFileFormat) {
      case 'JSON':
        return 'json';
      case 'CSV':
        return 'csv';
      case 'YAML':
        return 'yaml';
      default:
        return 'json';
    }
  }
}