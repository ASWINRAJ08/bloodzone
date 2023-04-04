import 'package:bloodzone/Feedback_page.dart';
import 'package:bloodzone/Notification_page.dart';
import 'package:bloodzone/Report_page.dart';
import 'package:bloodzone/Request_page.dart';
import 'package:bloodzone/donate_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Hospitals_page.dart';
import 'Map_page.dart';
import 'Settings_page.dart';

class Adhome extends StatefulWidget {
  const Adhome({Key? key}) : super(key: key);

  @override
  State<Adhome> createState() => _AdhomeState();
}

class _AdhomeState extends State<Adhome> {

  List<Image> images = [
    Image.asset('Assets/Images/bloodad1.jpg',fit: BoxFit.fill),
    Image.asset('Assets/Images/Blood-Donation-1.jpg',fit: BoxFit.fill),
    Image.asset('Assets/Images/bloodad2.png',fit: BoxFit.fill),
    Image.asset('Assets/Images/bloodad3.jpg',fit: BoxFit.fill),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator());
          }
          else {
            return Scaffold(
                drawer: NavigationDrawer(
                    children: [
                      DrawerHeader(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: InkWell(
                            child: CircleAvatar(
                                      radius: 50,
                                      child: Icon(CupertinoIcons.person,size: 70,color: Colors.pinkAccent[400]),
                                    ),
                          ),
                        ),
                      ),
                         Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text('name',
                                    style: TextStyle(color: Colors.pinkAccent[400],fontWeight: FontWeight.bold,fontSize: 18),)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Center(child: Text('phone number',
                                      style: TextStyle(color: Colors.pinkAccent[400],fontWeight: FontWeight.bold,fontSize: 18))),
                                )
                              ],
                            ),
                      ListTile(
                        leading: Icon(Icons.location_on_outlined,color: Colors.pinkAccent[400],),
                        title: Text('Map',style: TextStyle(color: Colors.pinkAccent[400])),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Mapview(),)),
                      ),
                      ListTile(
                          leading: Icon(Icons.settings_outlined,color: Colors.pinkAccent[400],),
                          title: Text('Settings',style: TextStyle(color: Colors.pinkAccent[400])),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Settingspage(),))
                      ),
                      ListTile(
                        leading: Icon(Icons.share_outlined,color: Colors.pinkAccent[400],),
                        title: Text('Refer a Friend',style: TextStyle(color: Colors.pinkAccent[400])),
                        onTap: () => const Mapview(),
                      ),
                      ListTile(
                        leading: Icon(Icons.star_rate_outlined,color: Colors.pinkAccent[400],),
                        title: Text('Rate Us',style: TextStyle(color: Colors.pinkAccent[400])),
                        onTap: () => const Mapview(),
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.exclamationmark_circle,color: Colors.pinkAccent[400],),
                        title: Text('About Us',style: TextStyle(color: Colors.pinkAccent[400])),
                        onTap: () => const Mapview(),
                      ),
                      ListTile(
                        leading: Icon(Icons.privacy_tip_outlined,color: Colors.pinkAccent[400],),
                        title: Text('Privacy Policy',style: TextStyle(color: Colors.pinkAccent[400])),
                        onTap: () => const Mapview(),
                      ),
                      ListTile(
                        leading: Icon(Icons.logout_outlined,color: Colors.pinkAccent[400],),
                        title: Text('Logout',style: TextStyle(color: Colors.pinkAccent[400])),
                        onTap: () => const Mapview(),
                      ),
                    ]
                ),
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  leading: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child:
                            InkWell(
                              onTap: () => Scaffold.of(context).openDrawer(),
                              child: const CircleAvatar(
                                      child: Icon(Icons.account_circle_outlined),
                                    )
                            )
                        ),
                  title: Text('Hi Admin !',
                            style: TextStyle(color: Colors.pinkAccent[400],fontWeight: FontWeight.bold)),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: IconButton(icon: Icon(CupertinoIcons.bell,color: Colors.pinkAccent[400],),
                          onPressed: () =>
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Notify(),))
                      ),
                    )
                  ],
                ),
                backgroundColor: Colors.white,
                body: ListView(
                  children: [
                    SizedBox(height: 220,
                      child: CarouselSlider(
                        options: CarouselOptions(
                            height: 180,
                            aspectRatio: 16/9,
                            autoPlay: true,
                            animateToClosest: true,
                            autoPlayInterval: const Duration(seconds: 4),
                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            initialPage: 0,
                            viewportFraction: 0.8,
                            scrollDirection: Axis.horizontal,
                            reverse: false,
                            autoPlayCurve: Curves.fastOutSlowIn
                        ),
                        items: images.map((image){
                          return
                            Builder(
                              builder: (BuildContext context) {
                                return Card(
                                  shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none
                                  ),
                                  elevation: 5,
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                    width: MediaQuery.of(context).size.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: image,
                                    ),
                                  ),
                                );
                              },
                            );
                        }).toList(),
                      ),
                    ),
                    DotsIndicator(
                      dotsCount: 5,
                      decorator: DotsDecorator(
                        color: Colors.pink.shade100,
                        activeColor: Colors.pinkAccent[400],
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        height: 265,
                        child: GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1/1.1,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15),
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Donate(),)),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white
                                  ),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Image(image: AssetImage('Assets/Images/bloodrequest.png'),height: 60),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.0,bottom: 10),
                                        child: Text('Donate Blood',style: TextStyle(fontSize: 12),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Request(),)),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white
                                  ),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Image(image: AssetImage('Assets/Images/donate.png'),height: 60),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.0,bottom: 10),
                                        child: Text('Request Blood',style: TextStyle(fontSize: 12),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const Mapview(),));
                              },
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white
                                  ),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Image(image: AssetImage('Assets/Images/bloodbank.png'),height: 50),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Text('Blood Bank',style: TextStyle(fontSize: 12),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Hospitals(),)),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white
                                  ),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Image(image: AssetImage('Assets/Images/hospitals.png'),height: 50),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Text('Hospitals',style: TextStyle(fontSize: 12),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Feedbackpage(),)),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white
                                  ),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Image(image: AssetImage('Assets/Images/feedback.png'),height: 50),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Text('Feedback',style: TextStyle(fontSize: 12),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Report(),)),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white
                                  ),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Image(image: AssetImage('Assets/Images/report.png'),height: 50),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Text('Report',style: TextStyle(fontSize: 12),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            );
          }
        }
    );
  }
}

