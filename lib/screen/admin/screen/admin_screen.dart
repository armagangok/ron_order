import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
import 'food_update_screen.dart';
import 'new_food_screen.dart';
import 'order_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PdfOrderProvider pdfService = PdfOrderProvider();

    TabBarController tabProvider = Provider.of<TabBarController>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: buildAppBar(
          context,
          pdfService,
        ),
        body: DefaultTabController(
          initialIndex: tabProvider.currentIndex,
          animationDuration: const Duration(milliseconds: 400),
          length: 3,
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Consumer(
                builder: (context, TabBarController controller, child) {
                  return TabBar(
                    isScrollable: true,
                    padding:
                        EdgeInsets.symmetric(vertical: context.getHeight(0.02)),
                    indicatorColor: Colors.black.withOpacity(0),
                    indicatorSize: TabBarIndicatorSize.label,
                    onTap: (value) => controller.changeIndex(value),
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      TabBarWidget(
                        text: "Yemek Ekle",
                        color: (controller.currentIndex == 0)
                            ? context.theme.primaryColor
                            : Colors.white,
                      ),
                      TabBarWidget(
                        text: "Yemek Güncelle",
                        color: (controller.currentIndex == 1)
                            ? context.theme.primaryColor
                            : Colors.white,
                      ),
                      TabBarWidget(
                        text: "Siperişler",
                        color: (controller.currentIndex == 2)
                            ? context.theme.primaryColor
                            : Colors.white,
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: context.getHeight(0.78),
                child: const TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    AddNewFoodScreen(),
                    FoodUpdateScreen(),
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

  //

  AppBar buildAppBar(BuildContext context, PdfOrderProvider pdfService) {
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
              ),
              Consumer(
                builder: (context, TabBarController indexProvider, _) {
                  OrderListController orderListProvider =
                      Provider.of<OrderListController>(context);
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
                maxFontSize: 20,
                minFontSize: 16,
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
