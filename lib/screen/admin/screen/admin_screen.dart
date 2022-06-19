import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ron_order/feature/viewmodel/order_viewmodel.dart';

import './add_new_food.dart';
import './food_update_screen.dart';
import './order_screen.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../core/tools/pdf_provider.dart';
import '../../../feature/components/topbar_widget.dart';
import '../components/components.dart';
import '../viewmodel/order_list_provider.dart';
import '../viewmodel/tab_index_provider.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PdfOrderProvider pdfService = PdfOrderProvider();
    OrderListProvider orderListProvider =
        Provider.of<OrderListProvider>(context);

    OrderViewmodel orderViewmodel = Provider.of<OrderViewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        title: Center(
          child: Text(
            "Admin Panel",
            style: context.textTheme.headline6,
          ),
        ),
        toolbarHeight: context.getHeight(0.1),
        actions: [
          Consumer(
            builder: ((context, TabIndexProvider indexProvider, child) {
              return IconButton(
                icon: Icon(
                  CupertinoIcons.trash,
                  color: (indexProvider.currentIndex == 2)
                      ? Colors.black
                      : Colors.black.withOpacity(0),
                ),
                onPressed: () {
                  buildDialog(
                    context,
                    () async => await orderViewmodel.deleteAllOrders(),
                    "Do you want to delete all orders?",
                  );
                },
              );
            }),
          ),
          const Center(child: LogoutButton()),
        ],
        leading: Consumer(
          builder: (context, TabIndexProvider indexProvider, child) {
            return Builder(builder: (context) {
              return Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      final pdf = await pdfService
                          .createOrderPdf(orderListProvider.getOrderList);
                      await pdfService.savePdfFile(
                        "ron_yemek_siparişler",
                        pdf,
                      );
                    },
                    icon: Icon(
                      CupertinoIcons.share,
                      color: (indexProvider.currentIndex == 2)
                          ? Colors.black
                          : Colors.black.withOpacity(0),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.trash,
                      color: (indexProvider.currentIndex == 2)
                          ? Colors.black.withOpacity(0)
                          : Colors.black.withOpacity(0),
                    ),
                  ),
                ],
              );
            });
          },
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Consumer(
              builder: (context, TabIndexProvider indexProvider, child) {
                return TabBar(
                  padding: const EdgeInsets.all(5),
                  indicatorColor: Colors.black.withOpacity(0),
                  indicatorSize: TabBarIndicatorSize.label,
                  onTap: (value) => indexProvider.changeIndex(value),
                  tabs: const [
                    TabBarWidget(text: "New Food"),
                    TabBarWidget(text: "Update Food"),
                    TabBarWidget(text: "Orders"),
                  ],
                );
              },
            ),
            SizedBox(
              height: context.getHeight(0.8),
              child: const TabBarView(
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
    );
  }
}
