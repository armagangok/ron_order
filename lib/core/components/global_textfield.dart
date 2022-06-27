import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../extension/context_extension.dart';

class GlobalTextField extends StatefulWidget {
  GlobalTextField({
    Key? key,
    required this.hintText,
    this.color = const Color.fromARGB(255, 251, 233, 232),
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.isObscured = false,
    this.labelText,
    this.prefixIcon,
    this.readOnly = false,
    this.minLines,
    this.maxLines = 1,
    this.height,
  })  : isObscure = isObscured,
        super(key: key);

  String? Function(String? text)? validator;
  String hintText;
  TextEditingController? controller;
  bool isObscured;
  bool isObscure;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  String? labelText;
  Widget? prefixIcon;
  bool readOnly;
  int? minLines;
  int? maxLines;
  double? height;
  Color? color;

  @override
  _GlobalTextFieldState createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getHeight(0.06),
      child: TextFormField(
        style: context.textTheme.bodyText2,
        // autovalidateMode: widget.autovalidateMode,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          hintText: widget.hintText,
          hintStyle: context.textTheme.caption,
          filled: true,
          fillColor: Colors.white,
          suffixIcon: buildObsecureIcon(),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          // enabledBorder: const OutlineInputBorder(
          //   borderSide: BorderSide.none,
          // ),
        ),
        obscureText: widget.isObscure,
        enabled: !widget.readOnly,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        readOnly: widget.readOnly,
        textInputAction: widget.textInputAction,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
      ),
    );
  }

  Widget? buildObsecureIcon() {
    if (widget.isObscured) {
      var icon =
          widget.isObscure ? CupertinoIcons.eye_slash : CupertinoIcons.eye;
      return IconButton(
        splashColor: Colors.transparent,
        icon: Icon(icon),
        onPressed: () => setState(() => widget.isObscure = !widget.isObscure),
      );
    }
    return null;
  }
}
