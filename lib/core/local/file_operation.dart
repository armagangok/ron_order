// // ignore_for_file: avoid_print

// import 'dart:io';

// import 'package:path_provider/path_provider.dart';

// class FileOperation {
//   //

//   Future<File> write(String data) async {
//     final file = await _localFile;
//     return file.writeAsString(data);
//   }

//   //

//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();
//     return directory.path;
//   }

//   //

//   Future<File> get _localFile async {
//     final path = await _localPath;
//     return File('$path/ron_digital_siparişler.txt');
//   }

//   //

//   Future<String> read() async {
//     try {
//       final file = await _localFile;
//       final contents = await file.readAsString();

//       return contents;
//     } catch (e) {
//       print("$e");
//       return "no data";
//     }
//   }

//   //

// }
