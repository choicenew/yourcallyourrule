import 'package:flutter/material.dart';
import 'package:world_flags/world_flags.dart';
import 'package:yourcallyourrule/features/common/widgets/dialogs/caller_id_dialog.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 国家选择对话框
/// 用于选择国家以查询来电显示信息
class CountrySelectionDialog extends StatelessWidget {
  final String phoneNumber;

  const CountrySelectionDialog({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(context)!.selectCountry),
            const SizedBox(height: 16),
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: WorldCountry.list.length,
                itemBuilder: (context, index) {
                  final country = WorldCountry.list[index];
                  return ListTile(
                    leading: CountryFlag.simplified(
                      country,
                      height: 24,
                    ),
                    title: Text(country.internationalName),
                    subtitle: Text(country.namesNative.first.common),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => CallerIdDialog(
                          phoneNumber: phoneNumber,
                          countryCode: country.code,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 显示国家选择对话框的静态方法
  static void show(BuildContext context, String phoneNumber) {
    showDialog(
      context: context,
      builder: (context) => CountrySelectionDialog(
        phoneNumber: phoneNumber,
      ),
    );
  }
}