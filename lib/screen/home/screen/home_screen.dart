import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extension/context_extension.dart';
import '../../../feature/components/chip_category_widget.dart';
import '../../../feature/components/food_grid_view_builder.dart';
import '../../../feature/components/topbar_widget.dart';
import '../../../feature/models/food_model.dart';
import '../../../feature/viewmodel/chip_viewmodel.dart';
import '../../../feature/viewmodel/food_viewmodel.dart';
import '../components/tcard_widget.dart';
import '../viewmodel/menu_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = context.getHeight(1);
    final double width = context.getWidth(1);
    final Color primaryColor = context.theme.primaryColor;
    final MenuViewmodel menuViewmodel = Provider.of<MenuViewmodel>(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: width * 0.025),
          children: [
            const TopBarWidget(),
            Row(
              children: [
                menuViewmodel.isTview
                    ? const SizedBox()
                    : const Expanded(
                        child: ChipCategoryWidgetBuilder(),
                      ),
                SizedBox(width: width * 0.01),
                chooseMenuTypeButton(width, menuViewmodel, primaryColor),
              ],
            ),
            Consumer(
              builder: (context, ChipViewmodel chipViewmodel, _) {
                String category = chipViewmodel.getChoosenCategory;

                return menuViewmodel.isTview
                    ? const TCardBuilder()
                    : FutureBuilder(
                        future: Provider.of<FoodViewmodel>(context)
                            .fetchFoodByCategory(category),
                        builder:
                            (context, AsyncSnapshot<List<FoodModel>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            final foodList = snapshot.data;
                            return SizedBox(
                              height: height * 0.8,
                              child: GridViewBuilderWidget(foodList: foodList!),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: Text("Waiting for data..."),
                            );
                          } else {
                            return const Center(
                              child: Text("An error occured..."),
                            );
                          }
                        },
                      );
              },
            )
          ],
        ),
      ),
    );
  }

  //
  //

  Widget chooseMenuTypeButton(
    double width,
    MenuViewmodel menuViewmodel,
    color,
  ) {
    return GestureDetector(
      child: Container(
        height: width * 0.13,
        width: width * 0.13,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Icon(
            CupertinoIcons.square_grid_2x2,
            color: menuViewmodel.isTview ? Colors.grey : color,
          ),
        ),
      ),
      onTap: () => menuViewmodel.changeMenuType(),
    );
  }
}
