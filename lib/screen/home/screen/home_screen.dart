import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extension/context_extension.dart';
import '../../../feature/components/chip_category_widget.dart';
import '../../../feature/components/food_grid_view_builder.dart';
import '../../../feature/components/topbar_widget.dart';
import '../../../feature/models/food_model.dart';
import '../../../feature/viewmodel/chip_controller.dart';
import '../../../feature/viewmodel/food_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = context.getHeight(1);
    final double width = context.getWidth(1);
    // final Color primaryColor = context.theme.primaryColor;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: width * 0.025),
            children: [
              const TopBarWidget(),
              const ChipCategoryWidgetBuilder(),
              SizedBox(width: width * 0.01),
              Consumer(
                builder: (context, ChipController chipViewmodel, _) {
                  String category = chipViewmodel.chosenCategory;

                  return FutureBuilder(
                    future: Provider.of<FoodViewmodel>(context)
                        .fetchFoodForUserScreen(category),
                    builder:
                        (context, AsyncSnapshot<List<FoodModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        final foodList = snapshot.data;
                        return SizedBox(
                          height: height * 0.8,
                          child: (foodList == null)
                              ? const Text(
                                  "Verilere erişmeye çalışırken bir sorun oluştu.")
                              : foodList.isEmpty
                                  ? const Center(
                                      child:
                                          Text("Aktif yemek bulunmamaktadır."),
                                    )
                                  : GridViewBuilderWidget(foodList: foodList),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: Text("Yemek verileri için bekleniyor..."),
                        );
                      } else {
                        return const Center(
                          child: Text("Beklenmeyen bi hata oluştu..."),
                        );
                      }
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  //
  //

  // Widget chooseMenuTypeButton(
  //   double width,
  //   MenuViewmodel menuViewmodel,
  //   color,
  // ) {
  //   return GestureDetector(
  //     child: Container(
  //       height: width * 0.13,
  //       width: width * 0.13,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         border: Border.all(
  //           color: Colors.white,
  //         ),
  //         borderRadius: const BorderRadius.all(
  //           Radius.circular(10),
  //         ),
  //       ),
  //       child: Center(
  //         child: Icon(
  //           CupertinoIcons.square_grid_2x2,
  //           color: menuViewmodel.isTview ? Colors.grey : color,
  //         ),
  //       ),
  //     ),
  //     onTap: () => menuViewmodel.changeMenuType(),
  //   );
  // }
}
