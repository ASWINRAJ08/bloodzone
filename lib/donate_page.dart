import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BottomNavigation_page.dart';
import 'Profile_Page.dart';

class Donate extends StatefulWidget {
  const Donate({Key? key}) : super(key: key);

  @override
  State<Donate> createState() => _DonateState();
}

class _DonateState extends State<Donate> {

  @override
  void initState() {
    getData();
    super.initState();
  }

  var uid;

  Future<void> getData() async {
    SharedPreferences spname = await SharedPreferences.getInstance();
    uid = spname.getString('id');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Requests').snapshots(),
        builder: (context,snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
              return
               Center(
                child: CircularProgressIndicator(
                  color: Colors.pinkAccent[400],
                ));
              }
              else {
                return
                  Scaffold(
                    appBar: AppBar(
                        automaticallyImplyLeading: false,
                        leading: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Navigation(),));
                            },
                            icon: const Icon(CupertinoIcons.arrow_left)),
                        title: Text('Requests', style: TextStyle(
                            color: Colors.pinkAccent[400],
                            fontWeight: FontWeight.bold),),
                        backgroundColor: Colors.transparent),
                    body: SafeArea(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          snapshot.data!.docs.sort((a, b) {
                            var adate = a['date'];
                            var bdate = b['date'];
                            return -adate.compareTo(bdate);
                          });
                          return
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Profile(id:snapshot.data!.docs[index]['id']),));
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: CupertinoColors.white,
                                        borderRadius: BorderRadius.circular(10)),
                                    height: 170,
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 9),
                                            child: Text('Need Before : ${snapshot.data!.docs[index]['required date']}',
                                                style: const TextStyle(
                                                    fontSize: 14,color: Colors.black)),
                                          ),
                                        ),
                                        Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(15),
                                                    child: Builder(
                                                        builder: (context) {
                                                          if(snapshot.data!.docs[index]['image']==null){
                                                            return
                                                              const CircleAvatar(
                                                                radius: 30,
                                                                child: Icon(Icons.account_circle_outlined),
                                                              );
                                                          }
                                                          else {
                                                            return CircleAvatar(
                                                              radius: 30,
                                                              foregroundImage: NetworkImage(
                                                                  snapshot.data!.docs[index]['image']),
                                                              child: const Icon(Icons.account_circle_outlined),
                                                            );
                                                          }
                                                        }
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            top: 10),
                                                        child: Text(snapshot.data!.docs[index]['user name'],
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontSize: 18,color: Colors.black),),
                                                      ),
                                                      Text(snapshot.data!.docs[index]['location'],
                                                          style: const TextStyle(
                                                              fontSize: 14,color: Colors.black)),
                                                      Text(snapshot.data!.docs[index]['phone number'],
                                                          style: const TextStyle(
                                                              fontSize: 14,color: Colors.black)),
                                                      const Padding(
                                                        padding: EdgeInsets.only(top: 18),
                                                        child: Text('Critical',
                                                            style: TextStyle(
                                                                fontSize: 14,color: Colors.black)),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10),
                                                        child: Text(snapshot.data!.docs[index]['time'],style: const TextStyle(fontSize: 10,color: Colors.black),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10,bottom: 7),
                                                        child: Text(snapshot.data!.docs[index]['date'],style: const TextStyle(fontSize: 10,color: Colors.black),),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .end,
                                            children: [
                                              Stack(
                                                children: [
                                                Icon(
                                                  CupertinoIcons.drop_fill,
                                                  size: 70,
                                                  color: Colors.pinkAccent[400],),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 22, left: 15),
                                                  child: Icon(Icons.water_drop,
                                                    color: Colors.pinkAccent[400],
                                                    size: 40,),
                                                ),
                                                 Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 20, top: 27),
                                                  child: SizedBox(
                                                    width: 30,
                                                    height: 30,
                                                    child: Center(
                                                      child: Text(snapshot.data!.docs[index]['blood group'],
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .bold),),
                                                    ),
                                                  ),
                                                ),
                                                Icon(CupertinoIcons.drop_fill,
                                                  color: Colors.pinkAccent[400],),
                                              ],),
                                              Row(
                                                children: [
                                                  IconButton(onPressed: () async {
                                                    await FlutterShare.share(
                                                        title: 'Example share',
                                                        text: 'Patient Name : ${snapshot.data!.docs[index]['pname']}\n'
                                                            'Required Blood Group : ${snapshot.data!.docs[index]['blood group']}\n'
                                                            'Need On Or Before : ${snapshot.data!.docs[index]['required date']}\n'
                                                            'Phone Number : ${snapshot.data!.docs[index]['phone number']}\n'
                                                            'Location : ${snapshot.data!.docs[index]['location']}'
                                                    );
                                                  },
                                                      icon: Icon(
                                                        Icons.share_outlined,
                                                        color: Colors
                                                            .pinkAccent[400],)),
                                                  Padding(
                                                    padding: const EdgeInsets.all(
                                                        10),
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context, builder: (context) {
                                                            return AlertDialog(
                                                              actionsAlignment: MainAxisAlignment.center,
                                                              title:   Column(
                                                                children: [
                                                                  Center(
                                                                    child: Text('You are about to Donate Your Blood to',
                                                                      style: TextStyle(fontSize: 15,color: Colors.pinkAccent[400]),)),
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(10),
                                                                    child: Text(snapshot.data!.docs[index]['user name'],
                                                                      style: const TextStyle(fontWeight: FontWeight.bold),),
                                                                  ),
                                                                ],
                                                              ),
                                                              content: SizedBox(
                                                                height: 150,
                                                                child: Column(
                                                                  children: [
                                                                    Stack(
                                                                      children: [
                                                                        Icon(
                                                                          CupertinoIcons.drop_fill,
                                                                          size: 70,
                                                                          color: Colors.pinkAccent[400],),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 22, left: 15),
                                                                          child: Icon(Icons.water_drop,
                                                                            color: Colors.pinkAccent[400],
                                                                            size: 40,),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 20, top: 27),
                                                                          child: SizedBox(
                                                                            width: 30,
                                                                            height: 30,
                                                                            child: Center(
                                                                              child: Text(snapshot.data!.docs[index]['blood group'],
                                                                                style: const TextStyle(
                                                                                    fontSize: 15,
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight
                                                                                        .bold),),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top: 10),
                                                                      child: Text('@',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.pinkAccent[400]),),
                                                                    ),
                                                                    Text('Location',
                                                                      style: TextStyle(fontSize: 15,color: Colors.pinkAccent[400]),),
                                                                    Text('Before ${snapshot.data!.docs[index]['required date']},05:00 PM',
                                                                        style: TextStyle(fontSize: 15,color: Colors.pinkAccent[400]))
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: [
                                                                ElevatedButton(
                                                                  onPressed: () =>
                                                                      Navigator.pushAndRemoveUntil(
                                                                          context, MaterialPageRoute(
                                                                        builder: (context) => const Donate(),),
                                                                              (route) => false),
                                                                  child: Text('Cancel',style: TextStyle(color: Colors.pinkAccent[400]),)
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.all(10),
                                                                  child: ElevatedButton(
                                                                    onPressed: () async {
                                                                      try {
                                                                        var data = await FirebaseFirestore.instance.collection("Donations").add({
                                                                          'name': snapshot.data!.docs[index]['user name'],
                                                                          'image': snapshot.data!.docs[index]['image'],
                                                                          'blood group': snapshot.data!.docs[index]['blood group'],
                                                                          'phone number': snapshot.data!.docs[index]['phone number'],
                                                                          'id': uid,
                                                                          'required date': snapshot.data!.docs[index]['required date'],
                                                                          'time': snapshot.data!.docs[index]['time'],
                                                                          'date': snapshot.data!.docs[index]['date'],
                                                                          'status': 'pending'
                                                                        });
                                                                      }
                                                                      catch (a) {
                                                                        if (kDebugMode) {
                                                                          print(a);
                                                                        }
                                                                      }

                                                                  showDialog(
                                                                      context: context, builder: (context) {
                                                                    return AlertDialog(title: const Center(
                                                                        child: Text('Success')),
                                                                      content: SizedBox(
                                                                        height: 100,
                                                                        child: Lottie.asset('Assets/Images/96673-success.json',
                                                                          animate: true,
                                                                          repeat: false,
                                                                          reverse: false,
                                                                        ),
                                                                      ),
                                                                      actions: [
                                                                        Center(child: FloatingActionButton(
                                                                          onPressed: () =>
                                                                              Navigator.pushAndRemoveUntil(
                                                                                  context, MaterialPageRoute(
                                                                                builder: (context) => const Navigation(),),
                                                                                      (route) => false),
                                                                          backgroundColor: Colors.pinkAccent[400],
                                                                          shape: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  50),
                                                                              borderSide: BorderSide.none),
                                                                          child: const Icon(
                                                                            Icons.arrow_forward_outlined,
                                                                            color: CupertinoColors.white,),
                                                                        ))
                                                                      ],
                                                                    );
                                                                  }
                                                                  );
                                                                    },
                                                                    child: Text('Accept',style: TextStyle(color: Colors.green[700]),),

                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          }
                                                          );

                                                        },
                                                        child: Text('Donate',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .pinkAccent[400],
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontSize: 15),)),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ]
                                    ),
                                  ),
                                ),
                              ),
                            );
                        },),
                    ),
                  );
              }
        }
    );
  }
}