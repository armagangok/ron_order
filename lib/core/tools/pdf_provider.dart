// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../../feature/models/order_model.dart';

class PdfOrderProvider {
  Future<Uint8List> createOrderPdf(List<OrderModel> orders) async {
    ThemeData myTheme = ThemeData.withFont(
      base: Font.ttf(
        await rootBundle.load("assets/fonts/Lato/Lato-Regular.ttf"),
      ),
    );

    final pdf = pw.Document(theme: myTheme);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a3,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  "RON YEMEK SIPARISLERI",
                  style: myTheme.header5.copyWith(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Expanded(
                child: gridView(orders, myTheme),
              ),
            ],
          );
        },
      ),
    );
    return await pdf.save();
  }

  //

  gridView(List<OrderModel> orders, pw.ThemeData myTheme) {
    return pw.GridView(
      crossAxisCount: 5,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),
          for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),
          for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),
          for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),
          for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),
          for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),
          for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),
          for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),
          for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),
          for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),for (var element in orders)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                element.orderer,
                style: myTheme.defaultTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.ListView.builder(
                itemCount: element.activeOrderList.length,
                itemBuilder: (context, indext) {
                  return pw.Text(
                    "${element.activeOrderList[indext].amount}x${element.activeOrderList[indext].foodName}",
                    textAlign: pw.TextAlign.left,
                    style: myTheme.defaultTextStyle.copyWith(fontSize: 10),
                  );
                },
              ),
            ],
          ),
      ],
    );
  }

  //

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    try {
      await file.writeAsBytes(byteList);
      await OpenFile.open(filePath);
    } catch (e) {
      print("$e");
    }
  }
}
