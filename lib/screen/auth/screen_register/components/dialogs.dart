import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogMessage extends StatefulWidget {
  final String text;
  const DialogMessage({
    Key? key,
    this.text = "",
  }) : super(key: key);

  @override
  State<DialogMessage> createState() => _DialogMessageState();
}

class _DialogMessageState extends State<DialogMessage> {
  
  @override
  Widget build(BuildContext context) {
    log("${context.widget.runtimeType}build run");
    return CupertinoAlertDialog(
      title: Column(
        children: [
          Text(widget.text),
        ],
      ),
    );
  }
}

Future<void> dialog(BuildContext context, text) async {
  await showDialog(
    context: context,
    builder: (_) => DialogMessage(text: text),
  );
}
