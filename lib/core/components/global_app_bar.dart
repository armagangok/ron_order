import 'package:flutter/material.dart';

import '../../core/extension/context_extension.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  GlobalAppBar({
    Key? key,
    this.enableBackButton = false,
    required this.title,
  }) : super(key: key);

  final String title;
  bool? enableBackButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: AppBar(
        title: Text(
          title,
          style: context.textTheme.headline6,
        ),
      
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
