import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/entities/label/predefined_label_entry.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
// 导入标签翻译工具类，替代原有的内联实现
import 'package:yourcallyourrule/features/labels/utils/label_translation_utils.dart';
/// 定义一个通用的标签服务接口
abstract class SelectLabelService {
  Future<List<String>> getAllLabelTexts();
  Future<List<PredefinedLabel>> getAllLabels();
  Future<String?> getLabelTextById(String labelId);
  Future<String?> getLabelIdByText(String labelText);
}

/// 预定义标签服务适配器，将PredefinedLabelService适配到SelectLabelService接口
class PredefinedLabelServiceAdapter implements SelectLabelService {
  final PredefinedLabelService predefinedLabelService;

  PredefinedLabelServiceAdapter(this.predefinedLabelService);

  @override
  Future<List<String>> getAllLabelTexts() {
    return predefinedLabelService.getAllLabelTexts();
  }
  
  @override
  Future<List<PredefinedLabel>> getAllLabels() {
    return predefinedLabelService.getAllLabels();
  }
  
  @override
  Future<String?> getLabelTextById(String labelId) async {
    // 通过标签ID获取标签文本
    final label = await predefinedLabelService.getLabelById(labelId);
    return label?.text; // 注意：翻译将在UI层通过LabelTranslationUtils处理
  }
  
  @override
  Future<String?> getLabelIdByText(String labelText) async {
    // 通过标签文本获取标签ID
    final labels = await predefinedLabelService.getLabelsByText(labelText);
    return labels.isNotEmpty ? labels.first.id : null;
  }
}

/// 可复用的标签选择组件，支持labelId
/// 这个组件可以被各种需要标签功能的服务复用
/// 例如：来电识别、短信过滤、规则设置等
class PublicSelectLabel extends ConsumerStatefulWidget {
  /// 初始选中的标签ID
  final String? initialLabelId;
  
  /// 初始选中的标签文本（如果没有提供initialLabelId）
  final String? initialLabelText;
  
  /// 电话号码（可选）
  final String? phoneNumber;
  
  /// 标签ID变更回调
  final ValueChanged<String> onLabelIdChanged;
  
  /// 标签服务
  final SelectLabelService? selectLabelService;
  
  /// 主题色
  final Color themeColor;
  
  /// 构造函数
  const PublicSelectLabel({
    super.key,
    this.initialLabelId,
    this.initialLabelText,
    this.phoneNumber,
    required this.onLabelIdChanged,
    this.selectLabelService,
    this.themeColor = const Color(0xFFF5A623),
  });

  @override
  ConsumerState<PublicSelectLabel> createState() => _PublicSelectLabelState();
}

class _PublicSelectLabelState extends ConsumerState<PublicSelectLabel> {
  String? _selectedLabelId;
  String? _selectedLabelText;
  List<String> _labels = [];
  Map<String, String> _labelTextToIdMap = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeSelectedLabel();
    _loadLabels();
  }
  
  Future<void> _initializeSelectedLabel() async {
    if (widget.initialLabelId != null) {
      _selectedLabelId = widget.initialLabelId;
      // 如果提供了初始标签ID，尝试获取对应的标签文本
      final service = widget.selectLabelService ?? 
          PredefinedLabelServiceAdapter(ref.read(predefinedLabelServiceProvider));
      _selectedLabelText = await service.getLabelTextById(_selectedLabelId!);
    } else if (widget.initialLabelText != null) {
      _selectedLabelText = widget.initialLabelText;
    }
  }

  Future<void> _loadLabels() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final SelectLabelService service = widget.selectLabelService ?? 
          PredefinedLabelServiceAdapter(ref.read(predefinedLabelServiceProvider));

      
      final labels = await service.getAllLabelTexts();
      final allLabels = await service.getAllLabels();
      
      // 构建标签文本到ID的映射
      final Map<String, String> textToIdMap = {};
      for (var label in allLabels) {
        if (label.id.isNotEmpty) {
          textToIdMap[label.text] = label.id;
        }
      }
      
      setState(() {
        _labels = labels;
        _labelTextToIdMap = textToIdMap;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.loadLabelFailed(e.toString())),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.selectLabel,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _buildLabelChips(),
        if (_selectedLabelText != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: widget.themeColor.withValues(alpha:0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: widget.themeColor.withValues(alpha:0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.label, color: widget.themeColor, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    '${AppLocalizations.of(context)!.selectedLabel}: ${_selectedLabelText != null ? LabelTranslationUtils.translateLabelText(context, _selectedLabelText!) : ''}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: widget.themeColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLabelChips() {
    if (_labels.isEmpty) {
      return Center(
        child: Column(
          children: [
            const Icon(Icons.label_off, color: Colors.grey, size: 48),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.noLabels, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                GoRouter.of(context).pushNamed(AppRouter.labelManagement).then((_) => _loadLabels());
              },
              icon: const Icon(Icons.add),
              label: Text(AppLocalizations.of(context)!.addLabelButton),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.themeColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      constraints: const BoxConstraints(maxHeight: 170),
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: _labels.map((labelText) {
            // 翻译标签文本
            final translatedText =
                LabelTranslationUtils.translateLabelText(context, labelText);
            final isSelected = labelText == _selectedLabelText;
            return ChoiceChip(
              label: Text(translatedText),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  final labelId = _labelTextToIdMap[labelText] ?? '';
                  setState(() {
                    _selectedLabelText = labelText;
                    _selectedLabelId = labelId;
                  });
                  widget.onLabelIdChanged(labelId);
                }
              },
              selectedColor: widget.themeColor,
              backgroundColor: Colors.grey.shade200,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              avatar: isSelected
                  ? const Icon(Icons.check, size: 12, color: Colors.orange)
                  : null,
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            );
          }).toList(),
        ),
      ),
    );
  }
}





/// 标签选择页面
class LabelSelectionPage extends ConsumerWidget {
  final String title;
  final ValueChanged<String> onLabelIdSelected;
  
  const LabelSelectionPage({
    super.key,
    required this.title,
    required this.onLabelIdSelected,
  });

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFF5A623),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: PublicSelectLabel(
          onLabelIdChanged: (labelId) {
            onLabelIdSelected(labelId);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}