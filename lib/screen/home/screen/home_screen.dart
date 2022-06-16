import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extension/context_extension.dart';
import '../../../global/components/chip_category_widget.dart';
import '../components/food_gridview.dart';
import '../components/tcard_widget.dart';
import '../../../global/components/topbar_widget.dart';
import '../../../global/viewmodel/chip_viewmodel.dart';
import '../viewmodel/menu_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final double height = context.getHeight(1);
    final double width = context.getWidth(1);
    final Color primaryColor = context.theme.primaryColor;
    final MenuViewmodel menuViewmodel = Provider.of<MenuViewmodel>(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          children: [
            const TopBarWidget(),
            // const SizedBox004(),
            // Text(
            //   "We think you might enjoy these specially selected dishes",
            //   style: context.textTheme.labelMedium,
            // ),
            // const SizedBox004(),
            Row(
              children: [
                menuViewmodel.isTview
                    ? const SizedBox()
                    : const Expanded(
                        child: ChipCategoryWidgetBuilder(isAdminView: true),
                      ),
                SizedBox(width: width * 0.01),
                chooseMenuTypeButton(width, menuViewmodel, primaryColor),
              ],
            ),
            buildFood(menuViewmodel),
          ],
        ),
      ),
    );
  }

  //

  Consumer<ChipViewmodel> buildFood(MenuViewmodel menuViewmodel) {
    return Consumer(
      builder: (BuildContext context, ChipViewmodel chipViewmodel, _) {
        String category = chipViewmodel.getChoosenCategory;

        return menuViewmodel.isTview
            ? const TCardBuilder()
            : SizedBox(
                height: context.getHeight(0.8),
                child: FoodGridView(category: category),
              );
      },
    );
  }

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
