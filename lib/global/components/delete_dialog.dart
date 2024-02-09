import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    Key? key,
    required this.text,
    required this.func,
  }) : super(key: key);

  final Function? func;
  final String text;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Column(
        children: [
          Text(
            text,
            textAlign: TextAlign.start,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  return await func!();
                },
                child: const Text("SİL"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("İPTAL"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<void> buildDialog(
  context,
  Function func,
  String text,
) async {
  await showDialog(
    context: context,
    builder: (_) => DeleteDialog(
      text: text,
      func: () async => await func(),
    ),
  );
}
