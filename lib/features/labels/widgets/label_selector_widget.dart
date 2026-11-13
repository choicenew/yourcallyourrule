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

/// M3 风格优雅流式排版 Label 选择器组件 (LabelSelectorWidget)
class LabelSelectorWidget extends ConsumerStatefulWidget {
  final String? initialLabelId;
  final String? initialLabelText;
  final String? phoneNumber;
  final ValueChanged<String> onLabelIdChanged;
  final SelectLabelService? selectLabelService;
  final Color? themeColor;

  const LabelSelectorWidget({
    super.key,
    this.initialLabelId,
    this.initialLabelText,
    this.phoneNumber,
    required this.onLabelIdChanged,
    this.selectLabelService,
    this.themeColor,
  });

  @override
  ConsumerState<LabelSelectorWidget> createState() => _LabelSelectorWidgetState();
}

class _LabelSelectorWidgetState extends ConsumerState<LabelSelectorWidget> {
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
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = widget.themeColor ?? theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).selectLabel,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        _isLoading
            ? const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator(strokeWidth: 2)))
            : _buildLabelChips(theme, primaryColor),
        if (_selectedLabelText != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withValues(alpha: 0.25)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.bookmark_rounded, color: primaryColor, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    '${AppLocalizations.of(context).selectedLabel}: ${_selectedLabelText != null ? LabelTranslationUtils.translateLabelText(context, _selectedLabelText!) : ''}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLabelChips(ThemeData theme, Color primaryColor) {
    if (_labels.isEmpty) {
      return Center(
        child: Column(
          children: [
            Icon(Icons.label_off_rounded, color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5), size: 40),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context).noLabels, style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 13)),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () {
                GoRouter.of(context).pushNamed(AppRouter.labelManagement).then((_) => _loadLabels());
              },
              icon: const Icon(Icons.add_rounded, size: 18),
              label: Text(AppLocalizations.of(context).addLabelButton),
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
          selectedColor: primaryColor.withValues(alpha: 0.2),
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected ? primaryColor : theme.colorScheme.outlineVariant,
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          labelStyle: TextStyle(
            color: isSelected ? primaryColor : theme.colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500,
            fontSize: 13,
          ),
          avatar: isSelected ? Icon(Icons.check_circle_rounded, size: 16, color: primaryColor) : null,
          showCheckmark: false,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        );
      }).toList(),
    );
  }
}
