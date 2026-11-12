import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/labels/utils/label_translation_utils.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

abstract class SelectLabelService {
  Future<List<String>> getAllLabelTexts();
  Future<List<PredefinedLabel>> getAllLabels();
  Future<String?> getLabelTextById(String labelId);
  Future<String?> getLabelIdByText(String labelText);
}

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
    final label = await predefinedLabelService.getLabelById(labelId);
    return label?.text;
  }

  @override
  Future<String?> getLabelIdByText(String labelText) async {
    final labels = await predefinedLabelService.getLabelsByText(labelText);
    return labels.isNotEmpty ? labels.first.id : null;
  }
}

class PublicSelectLabel extends ConsumerStatefulWidget {
  final String? initialLabelId;
  final String? initialLabelText;
  final String? phoneNumber;
  final ValueChanged<String> onLabelIdChanged;
  final SelectLabelService? selectLabelService;
  final Color themeColor;

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
          content: Text(AppLocalizations.of(context).loadLabelFailed(e.toString())),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).selectLabel,
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
                color: widget.themeColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: widget.themeColor.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.label, color: widget.themeColor, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    '${AppLocalizations.of(context).selectedLabel}: ${_selectedLabelText != null ? LabelTranslationUtils.translateLabelText(context, _selectedLabelText!) : ''}',
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
            Text(AppLocalizations.of(context).noLabels, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                GoRouter.of(context).pushNamed(AppRouter.labelManagement).then((_) => _loadLabels());
              },
              icon: const Icon(Icons.add),
              label: Text(AppLocalizations.of(context).addLabelButton),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.themeColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }
    
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _labels.map((labelText) {
        final translatedText = LabelTranslationUtils.translateLabelText(context, labelText);
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
          avatar: isSelected ? const Icon(Icons.check, size: 18, color: Colors.white) : null,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        );
      }).toList(),
    );
  }
}
