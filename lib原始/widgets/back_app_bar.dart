// back_app_bar.dart
import 'package:flutter/material.dart';

import '../../new_set_icons.dart';

class BackAppBar extends StatelessWidget {
  const BackAppBar({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(NewSet.arrow_left),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(title ?? ''),
      centerTitle: true, // 将标题居中
    );
  }
}
