import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Message_page.dart';

class Profile extends StatefulWidget {
  var id ;
  Profile({Key? key, required this.id}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  var uid ;
  List details = [];
  List donations = [];
  List requests = [];

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
          uid = widget.id ;
          details.clear();
          snapshot.data!.docs.forEach((element) {
            if (element.data()['id'] == uid) {
              details.add({
                'image': element.data()['image'],
                'name': element.data()['name'],
                'phone number': element.data()['phone number'],
                'blood group': element.data()['blood group'],
                'location': element.data()['location'],
                'id': element.data()['id'],
              });
            }
          });
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(),
            body: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20,left: 10,top: 20,bottom: 20),
                        child: Card(
                          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none
                          ),
                          elevation: 5,
                          child: SizedBox(
                            height: 160,
                            width: 130,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Builder(
                                  builder: (context) {
                                    if(details[0]['image']==null){
                                      return
                                          const Icon(Icons.account_circle_outlined,size: 60,);
                                    }
                                    else {
                                      return Image.network(
                                        details[0]['image'], fit: BoxFit.fill,);
                                    }
                                  }
                                )),
                          ),
                        ),
                      ),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(details[0]['name'], style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),),
                           Text(details[0]['phone number']),
                          Row(
                            children: [
                              Icon(CupertinoIcons.drop_fill,
                                  color: Colors.pinkAccent[400]),
                               Text(details[0]['blood group']),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                      children: [
                     Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Card(
                              elevation: 5,
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance.collection('Donations').snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.pinkAccent.shade400,
                                          ),
                                        );
                                      }
                                      else {
                                        donations.clear();
                                        snapshot.data!.docs.forEach((element) {
                                          if (element.data()['id'] == uid) {
                                            donations.add({
                                              'image': element.data()['image'],
                                              'name': element.data()['name'],
                                              'phone number': element
                                                  .data()['phone number'],
                                              'blood group': element
                                                  .data()['blood group'],
                                            });
                                          }
                                        });
                                        return
                                          SizedBox(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            height: 100,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  const Text('Donations'),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Text(donations.length.toString(),
                                                      style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                      }
                                    }
                                )
                  ),
                          ),
                        ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          elevation: 5,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('Requests').snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.pinkAccent.shade400,
                                    ),
                                  );
                                }
                                else {
                                  requests.clear();
                                  snapshot.data!.docs.forEach((element) {
                                    if (element.data()['id'] == uid) {
                                      requests.add({
                                        'image': element.data()['image'],
                                        'name': element.data()['name'],
                                        'phone number': element
                                            .data()['phone number'],
                                        'blood group': element
                                            .data()['blood group'],
                                        'id': element.data()['id'],
                                      });
                                    }
                                  });
                                  return SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    height: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          const Text('Requests'),
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(requests.length.toString(),
                                              style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              }
                            )
                        ),
                      ),
                    ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Card(
                              elevation: 5,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text('Ratings'),
                                      ),
                                      Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text('4',
                                            style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                          Icon(Icons.star,color: Colors.yellow[700],)
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ),
                  ],),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri.parse('tel:${details[0]['phone number']}');
                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch $url');
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.green[300],
                                borderRadius: BorderRadius.circular(50)),
                            child: const Center(
                                child: Icon(
                                  Icons.call, color: CupertinoColors.white,)),
                          ),
                        ),
                        InkWell(onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Messages(id:details[0]['id']),));
                        },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.pinkAccent[400],
                                borderRadius: BorderRadius.circular(50)),
                            child: const Center(
                                child: Icon(Icons.messenger_outline_outlined,
                                  color: CupertinoColors.white,)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        shape: OutlineInputBorder(borderRadius: BorderRadius
                            .circular(20),
                            borderSide: BorderSide.none),
                        elevation: 5,
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueGrey[50],),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10),
                                        child: Icon(
                                          CupertinoIcons.location_solid,
                                          color: Colors.pinkAccent[400],),
                                      ),
                                      Text(details[0]['location'], style: const TextStyle(
                                          fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      child: const ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                        child: GoogleMap(
                                            initialCameraPosition: CameraPosition(
                                              target: LatLng(
                                                  11.4050489, 75.7990983),
                                              zoom: 13.5,
                                            )),
                                      )
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          );
        }
      }
    );
  }
}
