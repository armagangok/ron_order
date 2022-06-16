import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../extension/context_extension.dart';

class GlobalElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? color;
  final Color? textColor;
  final Color? borderSideColor;
  final bool borderSideEnabled;

  const GlobalElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color,
    this.textColor = Colors.white,
    this.borderSideColor,
    this.borderSideEnabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color ?? context.theme.primaryColor,
        shape: RoundedRectangleBorder(
          side: borderSideEnabled
              ? BorderSide(color: borderSideColor ?? const Color(0xff999999))
              : BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        maximumSize: Size(
          context.getWidth(0.6),
          context.getHeight(0.06),
        ),
        minimumSize: Size(
          context.getWidth(0.6),
          context.getHeight(0.06),
        ),
      ),
      child: AutoSizeText(
        text,
        style: TextStyle(
          color: textColor,
        ),
        maxFontSize: 14,
        minFontSize: 13,
      ),
    );
  }
}
