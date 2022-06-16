import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import './food_update_screen.dart';
import './order_screen.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../global/components/topbar_widget.dart';
import 'add_new_food.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Admin Panel",
            style: context.textTheme.headline6,
          ),
          actions: const [
            Center(child: LogoutButton()),
          ],
        ),
        body: SizedBox(
          height: context.getHeight(9),
          child: Column(
            children: [
              TabBar(
                padding: const EdgeInsets.all(5),
                indicatorColor: Colors.black.withOpacity(0),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  TabBarWidget(text: "New Food"),
                  TabBarWidget(text: "Update Food"),
                  TabBarWidget(text: "Orders"),
                ],
              ),
              SizedBox(
                height: context.getHeight(0.8),
                child: TabBarView(
                  children: [
                    AddNewFoodScreen(),
                    const FoodUpdateScreen(),
                    OrderScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabBarWidget extends StatelessWidget {
  final String text;

  const TabBarWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.getHeight(1);
    final w = context.getWidth(1);
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        color: context.theme.primaryColor,
      ),
      height: h * 0.065,
      width: double.infinity,
      child: Center(
        child: AutoSizeText(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
