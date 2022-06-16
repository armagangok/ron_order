import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/dropdown_viewmodel.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DropDownProvider dropDownVmodel =
        Provider.of<DropDownProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
      child: DropdownButton<String>(
        value: dropDownVmodel.dropDownValue,
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        elevation: 16,
        underline: const SizedBox(),
        onChanged: (String? newValue) =>
            dropDownVmodel.changeCategory(newValue!),
        items: dropDownVmodel.categories
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
