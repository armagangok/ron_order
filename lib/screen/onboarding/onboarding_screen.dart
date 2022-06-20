import 'package:flutter/material.dart';
import 'package:ron_order/screen/root/root_screen.dart';

import '../../core/components/components.dart';
import '../../core/extension/context_extension.dart';
import '../../core/navigation/navigation.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heigth = context.getHeight(1);
    final width = context.getWidth(1);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: heigth,
            width: double.infinity,
            child: Image.asset(
              "assets/img/food.png",
              fit: BoxFit.fill,
            ),
          ),
          Container(
            height: heigth,
            width: double.infinity,
            color: const Color.fromARGB(79, 0, 0, 0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Column(
              children: [
                const Spacer(flex: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "No Worry,",
                        style: context.textTheme.headline4!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: " Handle Your Hunger",
                        style: context.textTheme.headline4!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: " with Ron Order!",
                        style: context.textTheme.headline4!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox004(),
                Text(
                  "Ron Order come to help you hunger problem with easy find any restaurant",
                  style: context.textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox004(),
                InkWell(
                  onTap: () {
                    push(const RootScreen(), context);
                  },
                  child: CircleAvatar(
                    radius: width * 0.085,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: width * 0.08,
                      backgroundColor: context.theme.primaryColor,
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: width * 0.08,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
