import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/navigation/navigation.dart';
import '../../../core/tools/pdf_provider.dart';
import '../../../feature/components/topbar_widget.dart';
import '../../../feature/viewmodel/order_viewmodel.dart';
import '../../home/screen/home_screen.dart';
import '../components/components.dart';
import '../viewmodel/order_list_provider.dart';
import '../viewmodel/tabbar_controller.dart';
import 'add_new_food.dart';
import 'food_update_screen.dart';
import 'order_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PdfOrderProvider pdfService = PdfOrderProvider();
    OrderListController orderListProvider =
        Provider.of<OrderListController>(context);
    OrderViewmodel orderViewmodel = Provider.of<OrderViewmodel>(context);
    TabBarController tabProvider = Provider.of<TabBarController>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: buildAppBar(
          context,
          pdfService,
          orderListProvider,
          orderViewmodel,
        ),
        body: DefaultTabController(
          initialIndex: tabProvider.currentIndex,
          animationDuration: const Duration(milliseconds: 600),
          length: 3,
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Consumer(
                builder: (context, TabBarController controller, child) {
                  return TabBar(
                    padding: EdgeInsets.zero,
                    indicatorColor: Colors.black.withOpacity(0),
                    indicatorSize: TabBarIndicatorSize.label,
                    onTap: (value) => controller.changeIndex(value),
                    tabs: [
                      TabBarWidget(
                        text: "New Food",
                        color: (controller.currentIndex == 0)
                            ? context.theme.primaryColor
                            : Colors.grey.withOpacity(0.6),
                      ),
                      TabBarWidget(
                        text: "Update Food",
                        color: (controller.currentIndex == 1)
                            ? context.theme.primaryColor
                            : Colors.grey.withOpacity(0.6),
                      ),
                      TabBarWidget(
                        text: "Orders",
                        color: (controller.currentIndex == 2)
                            ? context.theme.primaryColor
                            : Colors.grey.withOpacity(0.6),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: context.getHeight(0.82),
                child: const TabBarView(
                  physics: ClampingScrollPhysics(),
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

  AppBar buildAppBar(
    BuildContext context,
    PdfOrderProvider pdfService,
    OrderListController orderListProvider,
    OrderViewmodel orderViewmodel,
  ) {
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
                icon: const Icon(CupertinoIcons.person),
              ),
              Consumer(
                builder: (context, TabBarController indexProvider, _) {
                  return indexProvider.currentIndex == 2
                      ? IconButton(
                          onPressed: () async {
                            final pdf = await pdfService
                                .createOrderPdf(orderListProvider.getOrderList);
                            await pdfService.savePdfFile(
                              "ron_yemek_siparişler",
                              pdf,
                            );
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
              child: Text(
                'Admin Panel',
                style: context.textTheme.labelSmall,
              ),
            ),
          )
        ],
      ),
      actions: [
        Consumer(
          builder: ((context, TabBarController indexProvider, child) {
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
