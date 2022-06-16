// ignore_for_file: avoid_print

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/circle_container.dart';
import '../../../../core/extension/context_extension.dart';

import '../../../global/components/chip_category_widget.dart';
import '../../../global/models/food_model.dart';
import '../../../global/viewmodel/chip_viewmodel.dart';
import '../../../global/viewmodel/food_viewmodel.dart';
import '../viewmodel/activation_viewmodel.dart';

class FoodUpdateScreen extends StatelessWidget {
  const FoodUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.getHeight(1);
    final w = context.getWidth(1);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(10),
          children: [
            const ChipCategoryWidgetBuilder(isAdminView: true),
            Consumer(
              builder: (context, ChipViewmodel chipViewmodel, _) {
                String category = chipViewmodel.getChoosenCategory;

                return FutureBuilder<List<FoodModel>>(
                  future: FoodProvider().fetchFoodByCategory(category),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var foodList = snapshot.data;
                      return buildGridView(
                        foodList!,
                        h,
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: Text("Waiting for data..."),
                      );
                    } else {
                      return const Center(
                        child: Text("Error occured."),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridView(
    List<FoodModel> foodList,
    h,
  ) {
    return GridView.builder(
      itemCount: foodList.length,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisExtent: h * (0.34),
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return Consumer(
          builder: (context, ActivationViewmodel foodActivation, child) {
            return InkWell(
              onTap: () {
                foodList[index].isActive
                    ? foodActivation.inactivate(foodList[index])
                    : foodActivation.activate(foodList[index]);
              },
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          child: SizedBox(
                            height: h * 0.25,
                            width: h * 0.25,
                            child: CircleContainer(
                              imageUrl: foodList[index].imageUrl,
                            ),
                          ),
                        ),
                        AutoSizeText(
                          foodList[index].foodName,
                          textAlign: TextAlign.center,
                          style: context.textTheme.labelMedium,
                          maxFontSize: 18,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  foodList[index].isActive
                      ? const SizedBox()
                      : Container(
                          height: h * 0.34,
                          width: h * 0.34,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          child: Text(
                            "Deactivated",
                            textAlign: TextAlign.center,
                            style: context.textTheme.headline5!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
