import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  String videoURL;
  int videoIndex;
  String videoName;
  String videoThumbnail;
  String description;
  String duration;

  VideoModel(
      {required this.videoURL,
      required this.videoIndex,
      required this.videoName,
      required this.videoThumbnail,
      required this.description,
      required this.duration});

  factory VideoModel.fromMap(
      {required DocumentSnapshot<Map<String, dynamic>> doc}) {
    return VideoModel(
      videoURL: doc.data()!['videoURL'].toString(),
      videoIndex: int.parse(doc.data()!['videoIndex'].toString()),
      videoName: doc.data()!['name'].toString(),
      videoThumbnail: doc.data()!['videoThumbnail'],
      description: doc.data()!['description'],
      duration: doc.data()!['duration'],
    );
  }
}
