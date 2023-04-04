
import 'package:bloodzone/Feedback_page.dart';
import 'package:bloodzone/Notification_page.dart';
import 'package:bloodzone/Report_page.dart';
import 'package:bloodzone/Request_page.dart';
import 'package:bloodzone/SignIn_page.dart';
import 'package:bloodzone/User%20Profile.dart';
import 'package:bloodzone/donate_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Hospitals_page.dart';
import 'Map_page.dart';
import 'Settings_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override

  void initState() {
    getData();
    super.initState();
  }

  List details = [];
  List<Image> images = [
    Image.asset('Assets/Images/bloodad1.jpg',fit: BoxFit.fill),
    Image.asset('Assets/Images/Blood-Donation-1.jpg',fit: BoxFit.fill),
    Image.asset('Assets/Images/bloodad2.png',fit: BoxFit.fill),
    Image.asset('Assets/Images/bloodad3.jpg',fit: BoxFit.fill),
  ];

  bool switchValue = false ;
  var uid ;

  Future<void> getData() async {
    SharedPreferences spname = await SharedPreferences.getInstance();
    uid = spname.getString('id');
  }

  clear() async {
    SharedPreferences spname=await SharedPreferences.getInstance();
    spname.clear();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.pinkAccent.shade400,
            ),
          );
        }
        else {
          details.clear();
          snapshot.data!.docs.forEach((element) {
            if (element.data()['id'] == uid) {
              details.add({
                'image': element.data()['image'],
                'name': element.data()['name'],
                'phone number': element.data()['phone number']
              });
            }
          });
          return Scaffold(
            drawer: NavigationDrawer(
                children: [
                   DrawerHeader(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Edit(),)),
                        child: SizedBox(
                          height: 100,
                          child: Builder(
                            builder: (BuildContext context) {
                              if(details[0]['image'] == null){
                                return  CircleAvatar(
                                  child: Icon(
                                      CupertinoIcons.person, size: 70,
                                      color: Colors.pinkAccent[400]),
                                );
                              }
                              else {
                                  return
                                    CircleAvatar(
                                      foregroundImage: NetworkImage(details[0]['image']),
                                      radius: 50,
                                      onForegroundImageError: (exception, stackTrace) => const Icon(CupertinoIcons.person),
                                      child: Icon(
                                          CupertinoIcons.person, size: 70,
                                          color: Colors.pinkAccent[400]),
                                    );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Column(
                          children: [
                            Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text(details[0]['name'],
                              style: TextStyle(color: Colors.pinkAccent[400],fontWeight: FontWeight.bold,fontSize: 18),)),
                      ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Center(child: Text(details[0]['phone number'],
                                  style: TextStyle(color: Colors.pinkAccent[400],fontWeight: FontWeight.bold,fontSize: 18))),
                    )
                        ],
                        )
                  ),
                  ListTile(
                    leading: Icon(Icons.done,color: Colors.pinkAccent[400]),
                    title: Text('Available to Donate',style: TextStyle(color: Colors.pinkAccent[400])),
                    trailing: Switch(
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.pinkAccent[400],
                      value: switchValue,
                      onChanged: (value) {
                        setState(() {
                          switchValue = value;
                        });
                      },
                    ),
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
                    onTap: () async {
                      clear();
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                        return Signin();
                      },), (route) => false);
                    },
                  ),
                ]
            ),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: Builder(
                builder: (context) {
                  if(details[0]['image']==null){
                    return
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child:
                          InkWell(
                              onTap: () => Scaffold.of(context).openDrawer(),
                              child: const CircleAvatar(
                                child: Icon(Icons.account_circle_outlined),
                              )
                          )
                      );
                  }
                  else {
                    return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child:
                        InkWell(
                            onTap: () => Scaffold.of(context).openDrawer(),
                            child: CircleAvatar(
                              foregroundImage: NetworkImage(
                                  details[0]['image']),
                              onForegroundImageError: (exception, stackTrace) =>
                                  const Icon(CupertinoIcons.person),
                              child: const Icon(Icons.account_circle_outlined),
                            )
                        )
                    );
                  }
                }
              ),
              title: Text('Hi, ${details[0]['name']} !',
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
                  dotsCount: images.length,
                  position: 0,
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
                                      children: [
                                        const Image(image: AssetImage('Assets/Images/bloodrequest.png'),height: 60),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0,bottom: 10),
                                          child: Text('Donate Blood',
                                            style: TextStyle(fontSize: 12,color: Colors.pinkAccent[400]),),
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
                                    children: [
                                      const Image(image: AssetImage('Assets/Images/donate.png'),height: 60),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0,bottom: 10),
                                        child: Text('Request Blood',style: TextStyle(fontSize: 12,color: Colors.pinkAccent[400]),),
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
                                      children: [
                                        const Image(image: AssetImage('Assets/Images/bloodbank.png'),height: 50),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Text('Blood Bank',style: TextStyle(fontSize: 12,color: Colors.pinkAccent[400]),),
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
                                    children: [
                                      const Image(image: AssetImage('Assets/Images/hospitals.png'),height: 50),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text('Hospitals',style: TextStyle(fontSize: 12,color: Colors.pinkAccent[400]),),
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
                                    children: [
                                      const Image(image: AssetImage('Assets/Images/feedback.png'),height: 50),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text('Feedback',style: TextStyle(fontSize: 12,color: Colors.pinkAccent[400]),),
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
                                    children: [
                                      const Image(image: AssetImage('Assets/Images/report.png'),height: 50),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text('Report',style: TextStyle(fontSize: 12,color: Colors.pinkAccent[400]),),
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
