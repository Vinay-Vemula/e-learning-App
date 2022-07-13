import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class Pdf_model {
  String pdfURL;
  int pdfIndex;
  String pdfName;
  String pdfThumbnail;

  Pdf_model({
    required this.pdfURL,
    required this.pdfIndex,
    required this.pdfName,
    required this.pdfThumbnail,
  });

  factory Pdf_model.fromMap(
      {required DocumentSnapshot<Map<String, dynamic>> doc}) {
    return Pdf_model(
      pdfURL: doc.data()!['pdfUrl'].toString(),
      pdfIndex: int.parse(doc.data()!['pdfIndex'].toString()),
      pdfName: doc.data()!['name'].toString(),
      pdfThumbnail: doc.data()!['videoThumbnail'],
    );
  }
}
