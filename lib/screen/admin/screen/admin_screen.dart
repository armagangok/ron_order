import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './food_update_screen.dart';
import './new_food_screen.dart';
import './order_screen.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/navigation/navigation.dart';
import '../../../core/tools/pdf_provider.dart';
import '../../../feature/components/snackbar.dart';
import '../../../feature/components/topbar_widget.dart';
import '../../../feature/viewmodel/order_viewmodel.dart';
import '../../home/screen/home_screen.dart';
import '../components/components.dart';
import '../components/order_dialog.dart';
import '../viewmodel/order_list_provider.dart';
import '../viewmodel/tabbar_controller.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => context.dismissKeyboard(),
        child: Scaffold(
          appBar: buildAppBar(context),
          body: body(),
        ),
      ),
    );
  }

  Consumer<TabBarController> body() {
    return Consumer(
      builder: (
        BuildContext context,
        TabBarController tabProvider,
        Widget? _,
      ) {
        return DefaultTabController(
          initialIndex: tabProvider.currentIndex,
          animationDuration: const Duration(milliseconds: 400),
          length: 3,
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              TabBar(
                isScrollable: true,
                padding: EdgeInsets.symmetric(
                  vertical: context.getHeight(0.015),
                  // horizontal: context.getWidth(0.3),
                ),
                indicatorColor: Colors.black.withOpacity(0),
                indicatorSize: TabBarIndicatorSize.label,
                onTap: (value) => tabProvider.changeIndex(value),
                unselectedLabelColor: Colors.black,
                tabs: [
                  TabBarWidget(
                    text: "Yemek Ekle",
                    color: (tabProvider.currentIndex == 0)
                        ? context.theme.primaryColor
                        : Colors.white,
                  ),
                  TabBarWidget(
                    text: "Yemek Güncelle",
                    color: (tabProvider.currentIndex == 1)
                        ? context.theme.primaryColor
                        : Colors.white,
                  ),
                  TabBarWidget(
                    text: "Siparişler",
                    color: (tabProvider.currentIndex == 2)
                        ? context.theme.primaryColor
                        : Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: context.getHeight(0.78),
                child: const TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    NewFoodScreen(),
                    FoodUpdateScreen(),
                    OrderScreen(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                
                onPressed: () => getToRemove(const HomeScreen(), context),
                icon: const Icon(CupertinoIcons.home),
                padding: EdgeInsets.zero
              ),
              Consumer(
                builder: (context, TabBarController indexProvider, _) {
                  final PdfOrderProvider pdfService = PdfOrderProvider();
                  final OrderController orderListProvider =
                      Provider.of<OrderController>(context);
                  return indexProvider.currentIndex == 2
                      ? IconButton(
                          onPressed: () async {
                            try {
                              final pdf = await pdfService.createOrderPdf(
                                  orderListProvider.getOrderList);
                              await pdfService.savePdfFile(
                                "ron_yemek_siparişler",
                                pdf,
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbarWanrning("$e"));
                            }
                          },
                          icon: const Icon(
                            CupertinoIcons.share,
                            color: Colors.black,
                          ),
                        )
                      : const SizedBox();
                },
              )
            ],
          ),
          Expanded(
            child: Center(
              child: AutoSizeText(
                "Admin Panel",
                style: context.textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff32324D),
                ),
                maxFontSize: 18,
                minFontSize: 15,
              ),
            ),
          )
        ],
      ),
      actions: [
        Consumer(
          builder: ((context, TabBarController indexProvider, child) {
            OrderViewmodel orderViewmodel =
                Provider.of<OrderViewmodel>(context);
            return indexProvider.currentIndex == 2
                ? IconButton(
                    icon: const Icon(CupertinoIcons.trash, color: Colors.black),
                    onPressed: () {
                      buildDialog(
                        context,
                        () async => await orderViewmodel.deleteAllOrders(),
                        "Tüm siparişleri silmek istiyor musun?",
                      );
                    },
                  )
                : const SizedBox();
          }),
        ),
        const Center(child: LogoutButton()),
      ],
    );
  }
}
