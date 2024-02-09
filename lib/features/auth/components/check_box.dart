// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../core/extension/context_extension.dart';
// import '../screen_login/viewmodel/checkbox_provider.dart';

// class CheckBoxWidget extends StatelessWidget {
//   const CheckBoxWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final CheckBoxProvider checkBox = Provider.of<CheckBoxProvider>(context);
//     return Checkbox(
//       side: BorderSide(color: context.theme.primaryColor),
//       value: checkBox.value,
//       activeColor: Colors.greenAccent,
//       onChanged: (bool? e) => checkBox.changeCheckBox(e!),
//     );
//   }
// }
