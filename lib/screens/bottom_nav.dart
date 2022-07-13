import 'package:flutter/material.dart';
import 'package:perfex_e_learning/screens/profile.dart';


import 'home.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with SingleTickerProviderStateMixin {
  //String title = 'BottomNavigationBar';

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [
          Home(),
          //Videos(),
          Profile(),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(46.0),
          ),
          child: Container(
            color: Colors.cyan,
            child: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              labelStyle: const TextStyle(fontSize: 14.0),
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.black54, width: 0.0),
                insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
              ),
              //For Indicator Show and Customization
              indicatorColor: Colors.black54,
              tabs: const <Widget>[
                Tab(
                  icon: Icon(
                    Icons.home_filled,
                    size: 26.0,
                  ),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(
                    Icons.video_call,
                    size: 26.0,
                  ),
                  text: 'Saved',
                ),
                Tab(
                  icon: Icon(
                    Icons.person,
                    size: 26.0,
                  ),
                  text: 'Change password',
                ),
              ],
              controller: _tabController,
            ),
          ),
        ),
      ),
    );
  }
}
