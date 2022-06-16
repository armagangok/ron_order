// import 'package:flutter/material.dart';

// class AppCard extends StatelessWidget {
//   final double width;
//   final double height;
//   final double elevation;
//   final double borderRadiusAll;
//   final double borderWidth;
//   final Color? borderColor;
//   final Color? cardColor;
//   final bool isColumn;
//   final MainAxisAlignment mainAxisAlignment;
//   final CrossAxisAlignment crossAxisAlignment;
//   final MainAxisSize mainAxisSize;
//   final List<Widget>? children;

//   // ignore: use_key_in_widget_constructors
//   const AppCard({
//     this.width = 100.0,
//     this.height = 50.0,
//     this.elevation = 0.0,
//     this.borderRadiusAll = 6.0,
//     this.borderWidth = 1.0,
//     this.borderColor,
//     this.cardColor,
//     this.isColumn = true,
//     this.mainAxisAlignment = MainAxisAlignment.start,
//     this.crossAxisAlignment = CrossAxisAlignment.start,
//     this.mainAxisSize = MainAxisSize.min,
//     this.children,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: elevation,
//       borderRadius: BorderRadius.circular(borderRadiusAll),
//       child: Container(
//         width: width,
//         height: height,
//         decoration: BoxDecoration(
//           // color: cardColor ?? currentTheme(context).primaryColor,
//           borderRadius: BorderRadius.circular(borderRadiusAll),
//           border: Border.all(
//               width: borderWidth,
//               color: borderColor ?? Theme.of(context).focusColor),
//         ),
//         child: isColumn
//             ? Column(
//                 mainAxisAlignment: mainAxisAlignment,
//                 crossAxisAlignment: crossAxisAlignment,
//                 mainAxisSize: mainAxisSize,
//                 children: children ?? [],
//               )
//             : Row(
//                 mainAxisAlignment: mainAxisAlignment,
//                 crossAxisAlignment: crossAxisAlignment,
//                 mainAxisSize: mainAxisSize,
//                 children: children ?? [],
//               ),
//       ),
//     );
//   }
// }
