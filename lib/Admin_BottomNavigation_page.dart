import 'package:flutter/material.dart';

import 'Admin_Home_page.dart';
import 'Map_page.dart';
import 'admin_Search_page.dart';

class Adnavigation extends StatefulWidget {
  const Adnavigation({Key? key}) : super(key: key);

  @override
  State<Adnavigation> createState() => _AdnavigationState();
}

class _AdnavigationState extends State<Adnavigation> {

  int selectedPageIndex = 0;
  List buildBody = [const Adhome(),const adsearch(),const Mapview()] ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
            elevation: 1,
            height: 70,
            selectedIndex: selectedPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                selectedPageIndex = index;
              });
            },
            destinations: <NavigationDestination>[
              NavigationDestination(
                selectedIcon: Icon(Icons.home,color: Colors.pinkAccent[400],),
                icon: Icon(Icons.home_outlined,color: Colors.pinkAccent[400],),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.search,color: Colors.pinkAccent[400],),
                icon: Icon(Icons.search_outlined,color: Colors.pinkAccent[400],),
                label: 'Search',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.location_on,color: Colors.pinkAccent[400],),
                icon: Icon(Icons.location_on_outlined,color: Colors.pinkAccent[400],),
                label: 'Map',
              ),
            ]
        ),
        body: buildBody[selectedPageIndex]
    );
  }
}