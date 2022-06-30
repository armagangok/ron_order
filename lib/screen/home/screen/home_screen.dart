import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extension/context_extension.dart';
import '../../../core/components/components.dart';
import '../../../core/navigation/navigation.dart';
import '../../../core/network/firebase/view-models/firebase_viewmodel.dart';
import '../../../feature/components/chip_category_widget.dart';
import '../../../feature/components/food_grid_view_builder.dart';
import '../../../feature/components/topbar_widget.dart';
import '../../../feature/models/food_model.dart';
import '../../../feature/viewmodel/chip_controller.dart';
import '../../../feature/viewmodel/food_viewmodel.dart';
import '../../admin/screen/admin_screen.dart';
import 'active_order_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = context.getHeight(1);
    final double width = context.getWidth(1);
    FirebaseVmodel firebase = Provider.of<FirebaseVmodel>(context);
    // final Color primaryColor = context.theme.primaryColor;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: buildAppBar(
          firebase.user!.isAdmin,
          context,
        ),
        body: SafeArea(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: width * 0.025),
            children: [
              const ChipCategoryWidgetBuilder(),
              SizedBox(width: width * 0.01),
              buildFoodGridView()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: context.primaryColor.withOpacity(0.5),
          child: const Icon(
            CupertinoIcons.cart_fill,
            color: Colors.white,
          ),
          onPressed: () {
            getTo(const ActiveOrderScreen(), context);
          },
        ),
      ),
    );
  }

  //

  Widget buildFoodGridView() {
    return Consumer(
      builder: (context, ChipController chip, _) {
        return FutureBuilder<List<FoodModel>>(
          future: Provider.of<FoodViewmodel>(context).fetchFoodForUser(
            chip.chosenCategory,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return snapshot.data == null
                    ? const Center(
                        child:
                            Text("Bu kategoride aktif yemek bulunmamaktadır"),
                      )
                    : snapshot.data!.isEmpty
                        ? const Center(child: Text("Bu kategori şimdilik boş."))
                        : GridViewBuilderWidget(foodList: snapshot.data!);

              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    children: [
                      Text(
                        "Yemek verileri için bekleniyor...",
                        style: context.textTheme.bodyMedium!
                            .copyWith(color: Colors.black),
                      ),
                      const SizedBox004(),
                      const CircularProgressIndicator(),
                    ],
                  ),
                );

              case ConnectionState.none:
                return Center(
                  child: Text(
                    "İnternet bağlantınızı kontrol edin.",
                    style: context.textTheme.bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                );

              default:
                return Column(
                  children: [
                    Text(
                      "Bir sorun oluştu.",
                      style: context.textTheme.bodyMedium!
                          .copyWith(color: Colors.black),
                    ),
                    Text(snapshot.connectionState.name)
                  ],
                );
            }
          },
        );
      },
    );
  }
  //

  AppBar buildAppBar(
    bool isAdmin,
    BuildContext context,
  ) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: isAdmin
          ? GestureDetector(
              onTap: () => getToRemove(const AdminScreen(), context),
              child: const Icon(
                CupertinoIcons.person,
                color: Colors.black,
              ),
            )
          : const SizedBox(),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            LogoutButton(),
          ],
        )
      ],
      title: const Center(
        child: CartWidget(),
      ),
    );
  }
}
