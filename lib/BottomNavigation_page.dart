import 'package:flutter/material.dart';

import 'Chat_page.dart';
import 'History_page.dart';
import 'Home_page.dart';
import 'Map_page.dart';
import 'Search_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  int selectedPageIndex = 0;
  List buildBody = [const Home(),const Search(),const Mapview(),const Chat(),const Historypage()] ;

  Future<bool> showExitPopup() async {
    return await showDialog( 
      context: context,
      builder: (context) => AlertDialog(actionsAlignment: MainAxisAlignment.center,
        title: Center(child: Text('Exit App !',style: TextStyle(color: Colors.pinkAccent[400]),)),
        content: SizedBox(
          height: 50,
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      const Text('Do you Really Want to'),
                      const Text('Close the App ?')
                    ],
                  ),
                ),

            )),
        actions:[
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No',style: TextStyle(color: Colors.green[700]),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes',style: TextStyle(color: Colors.pinkAccent[400]),),
            ),
          ),
        ],
      ),
    )??false; 
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
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
              NavigationDestination(
                selectedIcon: Icon(Icons.message,color: Colors.pinkAccent[400],),
                icon: Icon(Icons.messenger_outline,color: Colors.pinkAccent[400],),
                label: 'Chat',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.history,color: Colors.pinkAccent[400],),
                icon: Icon(Icons.history_outlined,color: Colors.pinkAccent[400],),
                label: 'History',
              ),
            ]
        ),
        body: buildBody[selectedPageIndex]
      ),
    );
  }
}
