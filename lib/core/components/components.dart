import 'package:flutter/material.dart';

import '../extension/context_extension.dart';

class SizedBox004 extends StatelessWidget {
  const SizedBox004({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getHeight(0.03),
    );
  }
}

//
//
//

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        getDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "OR",
            style: context.textTheme.headline6,
          ),
        ),
        getDivider(),
      ],
    );
  }

  Widget getDivider() => const Expanded(child: Divider());
}

//
//
//


//
//
//

