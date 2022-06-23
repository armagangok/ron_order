import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extension/context_extension.dart';
import '../viewmodel/dropdown_viewmodel.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DropDownController provider =
        Provider.of<DropDownController>(context);
    return Container(
      height: context.getHeight(0.06),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: context.primaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: DropdownButton(
          underline: const SizedBox(),
          value: provider.dropDownValue,
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: context.primaryColor,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          elevation: 16,
          onChanged: (String? newValue) => provider.changeCategory(newValue!),
          items:
              provider.categories.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: AutoSizeText(
                value,
                style: context.textTheme.subtitle2,
                maxLines: 1,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
