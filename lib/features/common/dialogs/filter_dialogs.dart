import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/rules/utils/rule_action_display_utils.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

void showActionFilterDialog(BuildContext context, ValueChanged<RuleActionType?> onActionSelected) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.filterByAction),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.all),
            onTap: () {
              onActionSelected(null);
              Navigator.pop(context);
            },
          ),
          ...RuleActionType.values.map((type) {
            return ListTile(
              title: Text(RuleActionDisplayUtils.getActionTypeName(context, type)),
              onTap: () {
                onActionSelected(type);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ],
      ),
    ),
  );
}

void showLabelFilterDialog(BuildContext context, ValueChanged<String?> onLabelSelected, {Color? themeColor}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.filterByLabel),
      content: SizedBox(
        width: double.maxFinite,
        child: PublicSelectLabel(
          onLabelIdChanged: (labelId) {
            onLabelSelected(labelId);
            Navigator.pop(context);
          },
          themeColor: themeColor ?? Colors.blue,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.cancelButton),
        ),
        TextButton(
          onPressed: () {
            onLabelSelected(null);
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.clearFilter),
        ),
      ],
    ),
  );
}