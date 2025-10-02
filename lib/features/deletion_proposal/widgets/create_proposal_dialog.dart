import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:yourcallyourrule/common/utils/phone_utils.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 创建删除提议对话框
class CreateProposalDialog extends StatefulWidget {
  final Future<void> Function(String phoneNumber, String reason, int riskLevel) onSubmit;

  const CreateProposalDialog({
    super.key,
    required this.onSubmit,
  });

  @override
  State<CreateProposalDialog> createState() => _CreateProposalDialogState();
}

class _CreateProposalDialogState extends State<CreateProposalDialog> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _reasonController = TextEditingController();
  final _countryCodeController = TextEditingController();
  
  int _selectedRiskLevel = 3;
  bool _isSubmitting = false;
  
  List<String> get _commonReasons => [
    AppLocalizations.of(context)!.reasonInaccurateInfo,
    AppLocalizations.of(context)!.reasonOutdated,

    AppLocalizations.of(context)!.reasonPrivacy,
    AppLocalizations.of(context)!.reasonNotInService,
    AppLocalizations.of(context)!.reasonWronglyIdentified,
    AppLocalizations.of(context)!.reasonOther,
  ];
  
  String? _selectedCommonReason;

  @override
  void dispose() {
    _phoneController.dispose();
    _reasonController.dispose();
    _countryCodeController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        final parsed = await PhoneUtils.parsePhoneNumberWithIso(
          _phoneController.text,
          _countryCodeController.text,
        );
        final e164Number = parsed['e164Number'];

        if (e164Number == null || e164Number.isEmpty) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Invalid phone number or country code.')),
            );
          }
          return;
        }

        await widget.onSubmit(
          e164Number,
          _reasonController.text,
          _selectedRiskLevel,
        );

        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Submission failed: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    Icons.report_problem,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.createProposalTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Country Code input
                      Text(
                          AppLocalizations.of(context)!.countryCodeLabel,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _countryCodeController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.countryCodeHint,
                          prefixIcon: const Icon(Icons.public),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.countryCodeRequired;
                          }
                          if (value.length != 2) {
                            return AppLocalizations.of(context)!.countryCodeTwoLetters;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Phone number input
                      Text(
                        '${AppLocalizations.of(context)!.phoneNumber} *',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.enterPhoneNumber,
                          prefixIcon: const Icon(Icons.phone),
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\s\(\)]')),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.phoneNumberRequired;
                          }
                          if (value.length < 7) {
                            return AppLocalizations.of(context)!.phoneNumberMinDigits;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      
                      // Common reasons
                      Text(
                        AppLocalizations.of(context)!.reason,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _commonReasons.map((reason) {
                          final isSelected = _selectedCommonReason == reason;
                          return FilterChip(
                            label: Text(reason),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _selectedCommonReason = selected ? reason : null;
                                if (selected && reason != 'Other') {
                                  _reasonController.text = reason;
                                } else if (reason == 'Other') {
                                  _reasonController.clear();
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      
                      // Detailed reason
                      Text(
                        '${AppLocalizations.of(context)!.reason} *',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _reasonController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.provideDetailedExplanation,
                          border: const OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        maxLength: 500,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.reasonRequired;
                          }
                          if (value.length < 10) {
                            return AppLocalizations.of(context)!.reasonMinCharacters;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      
                      // Risk level
                      Text(
                        '${AppLocalizations.of(context)!.riskLevel} *',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.riskLevelLabel} $_selectedRiskLevel',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  _buildRiskLevelChip(_selectedRiskLevel),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Slider(
                                value: _selectedRiskLevel.toDouble(),
                                min: 1,
                                max: 5,
                                divisions: 4,
                                label: _getRiskLevelDescription(_selectedRiskLevel),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedRiskLevel = value.round();
                                  });
                                },
                              ),
                              Text(
                                _getRiskLevelDescription(_selectedRiskLevel),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Guidelines
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  AppLocalizations.of(context)!.guidelinesLabel,
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              
                              AppLocalizations.of(context)!.reportingGuidelines,
                              
                              
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
                    child: Text(AppLocalizations.of(context)!.cancelButton),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(AppLocalizations.of(context)!.submit),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRiskLevelChip(int riskLevel) {
    Color chipColor;
    String label;
    
    switch (riskLevel) {
      case 5:
        chipColor = Colors.red;
        label = 'Critical';
        break;
      case 4:
        chipColor = Colors.deepOrange;
        label = 'High';
        break;
      case 3:
        chipColor = Colors.orange;
        label = 'Medium';
        break;
      case 2:
        chipColor = Colors.yellow.shade700;
        label = 'Low';
        break;
      case 1:
      default:
        chipColor = Colors.green;
        label = 'Very Low';
        break;
    }

    return Chip(
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: chipColor,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  String _getRiskLevelDescription(int riskLevel) {
    switch (riskLevel) {
      case 1:
        return 'Very Low - Minor annoyance, infrequent calls';
      case 2:
        return 'Low - Occasional unwanted calls';
      case 3:
        return 'Medium - Regular spam or telemarketing';
      case 4:
        return 'High - Persistent harassment or scam attempts';
      case 5:
        return 'Critical - Dangerous scams or threats';
      default:
        return 'Unknown';
    }
  }
}