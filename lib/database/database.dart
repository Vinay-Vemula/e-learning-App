import 'package:firebase_auth/firebase_auth.dart';
import 'package:perfex_e_learning/helpers/constants.dart';
import 'package:perfex_e_learning/models/model_video.dart';

class FireStoreDB {
  // GET IMAGE LIST

  // GETTING USER DATA
  static Future<String> getUserClassName() async {
    return await firebaseFirestore
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      return value.get('userClass');
    });
  }

  static Future<List<VideoModel>> getClassVideos() async {
    List<VideoModel> videos = <VideoModel>[];
    return await getUserClassName().then((String userClassname) {
      // print(userClassname);
      return firebaseFirestore
          .collection('Videos')
          .doc(userClassname)
          .collection('Courses')
          .get()
          .then((videoList) {
        //print(videoList);

        for (var videoSnapShot in videoList.docs) {
          final videois = VideoModel.fromMap(doc: videoSnapShot);

          // print(videois.videoName);
          videos.add(videois);
        }
        return videos;
      });
    });
  }
}
