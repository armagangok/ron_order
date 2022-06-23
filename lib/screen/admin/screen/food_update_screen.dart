// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ron_order/feature/models/food_model.dart';
import 'package:ron_order/feature/viewmodel/food_viewmodel.dart';

import '../../../feature/components/chip_category_widget.dart';
import '../../../feature/components/food_grid_view_builder.dart';
import '../../../feature/viewmodel/chip_viewmodel.dart';

class FoodUpdateScreen extends StatelessWidget {
  const FoodUpdateScreen({Key? key}) : super(key: key);

//   @override
//   State<FoodUpdateScreen> createState() => _FoodUpdateScreenState();
// }

// class _FoodUpdateScreenState extends State<FoodUpdateScreen> {
//   Map<String, List<FoodModel>> all = {
//     "dishes": [],
//     "sub dishes": [],
//     "deserts": [],
//     "soups": [],
//     "salads": [],
//     "others": []
//   };

//   @override
//   void initState() {
//     print("triggered");
//     FoodViewmodel()
//         .fetchFoodForAdminScreen("dishes")
//         .then((dishes) => all["dishes"] = dishes);

//     FoodViewmodel()
//         .fetchFoodForAdminScreen("sub dishes")
//         .then((subDishes) => all["sub dishes"] = subDishes);

//     FoodViewmodel()
//         .fetchFoodForAdminScreen("deserts")
//         .then((deserts) => all["deserts"] = deserts);

//     FoodViewmodel()
//         .fetchFoodForAdminScreen("soups")
//         .then((soups) => all["soups"] = soups);

//     FoodViewmodel()
//         .fetchFoodForAdminScreen("salads")
//         .then((salads) => all["salads"] = salads);

//     FoodViewmodel()
//         .fetchFoodForAdminScreen("others")
//         .then((others) => all["others"] = others);

//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(10),
          children: [
            const ChipCategoryWidgetBuilder(),
            Consumer(
              builder: (context, ChipController chip, _) {
                // print(chipViewmodel.getChoosenCategory);
                // return all[chipViewmodel.getChoosenCategory]!.isNotEmpty
                //     ? GridViewBuilderWidget(
                //         foodList: all[chipViewmodel.getChoosenCategory]!,
                //         isActivationWidget: true,
                //       )
                //     : const Center(
                //         child: Text(
                //             "Something went wrong while fetching food from database."),
                //       );
                return FutureBuilder<List<FoodModel>>(
                  future: FoodViewmodel()
                      .fetchFoodForAdminScreen(chip.chosenCategory),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var foodList = snapshot.data;
                      return GridViewBuilderWidget(
                        foodList: foodList!,
                        isActivationWidget: true,
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
}
