import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_new_food.dart';
import './food_update_screen.dart';
import './order_screen.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../core/local/pdf_service.dart';
import '../../../feature/components/topbar_widget.dart';
import '../viewmodel/order_provider.dart';
import '../viewmodel/tab_index_provider.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PdfOrderService pdfService = PdfOrderService();
    OrderListProvider orderListProvider =
        Provider.of<OrderListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Admin Panel",
            style: context.textTheme.headline6,
          ),
        ),
        actions: const [
          Center(child: LogoutButton()),
        ],
        leading: Consumer(
          builder: (context, TabIndexProvider indexProvider, child) {
            return (indexProvider.currentIndex == 2)
                ? IconButton(
                    onPressed: () async {
                      final a = await pdfService
                          .createOrder(orderListProvider.getOrderList);
                      await pdfService.savePdfFile("ron_yemek_siparişler", a);
                    },
                    icon: const Icon(
                      CupertinoIcons.share,
                      color: Colors.black,
                    ),
                  )
                : const SizedBox();
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

class TabBarWidget extends StatelessWidget {
  final String text;

  const TabBarWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.getHeight(1);
    final w = context.getWidth(1);
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        color: context.theme.primaryColor,
      ),
      height: h * 0.065,
      width: double.infinity,
      child: Center(
        child: AutoSizeText(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
