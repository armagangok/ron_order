import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../feature/components/snackbar.dart';

class DeleteOrderDialog extends StatelessWidget {
  const DeleteOrderDialog({
    Key? key,
    required this.text,
    required this.func,
  }) : super(key: key);

  final Function func;
  final String text;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Column(
        children: [
          Text(text),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () async {
                  func().whenComplete(() {
                    Navigator.pop(context);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    snackbarSuccess("Siparişler başarıyla silindi."),
                  );
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
    builder: (_) => DeleteOrderDialog(
      text: text,
      func: () async => await func(),
    ),
  );
}
