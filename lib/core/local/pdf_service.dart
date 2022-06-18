import 'dart:io';
import 'dart:typed_data';

import 'package:open_file/open_file.dart';
//import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../feature/models/order_model.dart';

class PdfOrderService {
  Future<Uint8List> createOrder(List<OrderModel> orders) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text(
                "RON YEMEK SIPARISLERI",
                style: pw.TextStyle(
                  fontSize: 25,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Expanded(
                child: gridView(orders),
              ),
            ],
          );
        },
      ),
    );
    return await pdf.save();
  }

  //

  gridView(List<OrderModel> orders) {
    return pw.GridView(
      crossAxisCount: 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        for (var element in orders)
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  element.orderer,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                pw.ListView.builder(
                  itemCount: element.orderList.length,
                  itemBuilder: (context, indext) {
                    return pw.Column(
                      children: [
                        pw.Text(element.orderList[indext].foodName),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }

  //

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filePath);
  }
}
