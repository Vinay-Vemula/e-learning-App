

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:perfex_e_learning/database/database.dart';
import 'package:perfex_e_learning/models/model_video.dart';
import 'package:perfex_e_learning/screens/login_screen/components/skelton.dart';
import 'package:perfex_e_learning/screens/login_screen/login_screen.dart';
import 'package:perfex_e_learning/screens/video_player.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            'Course Videos',
            style: TextStyle(
                color: Colors.white,
                //  fontSize: 25,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 61, 86, 224),
        actions: [
          IconButton(
              onPressed: () async => {
                    await FirebaseAuth.instance.signOut(),
                    //await Storage.delete(key:"uid"),
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false)
                  },
              icon: const Padding(
                padding: EdgeInsets.only(right: 45),
                child: Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: _body(),
      floatingActionButton: FabCircularMenu(
          fabColor: Colors.indigoAccent.withAlpha(196),
          alignment: Alignment.bottomRight,
          ringColor: Colors.indigo.withAlpha(80),
          ringDiameter: 360.0,
          ringWidth: 90,
          fabSize: 50.0,
          fabElevation: 50.0,
          fabOpenColor: Colors.indigo.withAlpha(196),
          fabIconBorder: const CircleBorder(),
          children: <Widget>[
            RawMaterialButton(
              onPressed: () {
                // displayMessage(context, 'Home Clicked');
                Get.to(const Explorer(Colors.indigo));
              },
              elevation: 50.0,
              padding: const EdgeInsets.all(15.0),
              shape: const CircleBorder(),
              //fillColor: Colors.black,
              child: const Icon(
                Icons.home,
                size: 25.0,
                color: Colors.indigoAccent,
              ),
            ),
            RawMaterialButton(
              onPressed: () {
                //displayMessage(context, 'Profile Clicked');
              },
              elevation: 56.0,
              padding: const EdgeInsets.all(15.0),
              shape: const CircleBorder(),
              //fillColor: Colors.black,
              child: const Icon(
                Icons.person,
                color: Colors.black,
                size: 25.0,
              ),
            ),
            RawMaterialButton(
              onPressed: () {
                // displayMessage(context, 'Home Clicked');
              },
              elevation: 56.0,
              padding: const EdgeInsets.all(15.0),
              shape: const CircleBorder(),
              //fillColor: Colors.black,
              child: const Icon(
                Icons.download,
                size: 25.0,
                color: Colors.black,
              ),
            ),
          ]),
    );
  }

  Widget _body() {
    return FutureBuilder(
        future: FireStoreDB.getClassVideos(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: ((context, int index) {
                    return _listItem(snapshot.data![index]);
                  }));
              // return GridView.extent(
              //     maxCrossAxisExtent: 200,
              //     children: List.generate(snapshot.data!.length, (index) {
              //       return _gridItem(snapshot.data![index]);
              //     }));
            } else {
              return const Text('error loading');
            }
          } else {
            return const Explorer(Colors.indigo);
          }
        });
  }

  Widget _listItem(VideoModel videoModel) {
    return GestureDetector(
      onTap: () {
        Get.to(() => VideoPlayer(
              videoUrl: videoModel.videoURL,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
            elevation: 30,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SizedBox(
                    height: 115,
                    width: 115,
                    child: CachedNetworkImage(
                      imageUrl: videoModel.videoThumbnail,
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                            height: 15, child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageBuilder:
                          (context, ImageProvider<Object> imageProvider) =>
                              Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Text(videoModel.videoName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 250,
                      child: Text(videoModel.description,
                          overflow: TextOverflow.visible,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('Duration:${videoModel.duration}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        )),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  // Widget _gridItem(VideoModel videoModel) {
  //   return GridTile(
  //     footer: Center(
  //         child: Padding(
  //       padding: const EdgeInsets.all(8),
  //       child: Text(videoModel.videoName,
  //           overflow: TextOverflow.ellipsis,
  //           maxLines: 1,
  //           style: const TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.bold,
  //           )),
  //     )),
  //     child: GestureDetector(
  //       onTap: () {
  //         Get.to(() => VideoPlayer(
  //               videoUrl: videoModel.videoURL,
  //             ));
  //       },
  //       child: Card(
  //           elevation: 4,
  //           clipBehavior: Clip.antiAlias,
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //           child: Material(
  //             color: Colors.transparent,
  //             child: Stack(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(15.0),
  //                   child: CachedNetworkImage(
  //                     imageUrl: videoModel.videoThumbnail,
  //                     placeholder: (context, url) => const Center(
  //                       child: SizedBox(
  //                         width: 50,
  //                         height: 50,
  //                         child: CircularProgressIndicator(),
  //                       ),
  //                     ),
  //                     errorWidget: (context, url, error) =>
  //                         const Icon(Icons.error),
  //                     imageBuilder: (context, imageProvider) => Container(
  //                       decoration: BoxDecoration(
  //                         image: DecorationImage(
  //                             image: imageProvider, fit: BoxFit.contain),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           )),
  //     ),
  //   );
  // }
}
