import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/extension/context_extension.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlobalAppBar({
    Key? key,
    required this.title,
    this.enableBackButton = false,
  }) : super(key: key);

  final String title;
  final bool enableBackButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: AppBar(
        leading: enableBackButton
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(CupertinoIcons.back))
            : const SizedBox(),
        title: Center(
          child: Text(
            title,
            style: context.textTheme.headline6,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.abc,
              color: Colors.amber.withOpacity(0),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
