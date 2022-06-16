import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? heigth;

  const CircleContainer({
    Key? key,
    required this.imageUrl,
    this.width,
    this.heigth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      width: heigth,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(360.0),
        ),
        color: Colors.redAccent,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
