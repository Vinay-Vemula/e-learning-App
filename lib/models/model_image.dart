import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModel {
  String imageName;
  String imageURL;
  int imageIndex;
  Timestamp createdAt;

  ImageModel(
      {required this.imageName,
      required this.imageURL,
      required this.imageIndex,
      required this.createdAt});

  factory ImageModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> doc}) {
    return ImageModel(
        imageName: doc.data()!['imageName'],
        imageURL: doc.data()!['imageURL'],
        imageIndex: int.parse(doc.data()!['imageIndex'].toString()),
        createdAt: doc.data()!['createdAt']);
  }
}
