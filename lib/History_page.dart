import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Historypage extends StatefulWidget {
  const Historypage({Key? key}) : super(key: key);

  @override
  State<Historypage> createState() => _Historypage();
}

class _Historypage extends State<Historypage> {

  @override
  void initState() {
    getData();
    super.initState();
  }

  var uid;
  List details = [];
  List donations = [];

  Future<void> getData() async {
    SharedPreferences spname = await SharedPreferences.getInstance();
    uid = spname.getString('id');
  }

  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                actions: [
                  TextButton(onPressed: () {

                  },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text('Clear All', style: TextStyle(color: Colors
                            .pinkAccent[400]),),
                      )
                  )
                ],
                bottom: TabBar(
                  indicatorColor: Colors.pinkAccent[400],
                  isScrollable: true,
                  tabs: const [
                    Tab(
                      text: 'Your Donations',
                    ),
                    Tab(
                      text: 'Your Requests',
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Donations').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                            donations.add(
                                {
                                  'user name': element.data()['name'],
                                  'required date': element.data()['required date'],
                                  'blood group': element.data()['blood group'],
                                  'phone number': element.data()['phone number'],
                                  'time': element.data()['time'],
                                  'date': element.data()['date'],
                                  'image': element.data()['image'],
                                  'status': element.data()['status'],
                                  'location': element.data()['location']
                                });
                          }
                        });
                        if (donations.isEmpty) {
                          return
                            const Center(
                                child: Text('No Requests Yet'));
                        }
                        else {
                          return ListView.builder(
                            itemCount: donations.length,
                            itemBuilder: (context, index) {
                              return
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 15, right: 15),
                                  child: Card(
                                    elevation: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: CupertinoColors.white,
                                          borderRadius: BorderRadius.circular(
                                              10)),
                                      height: 170,
                                      child: Stack(
                                          children: [
                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 9),
                                                child: Text(
                                                    'Need Before : ${donations[index]['required date']}',
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
                                                          padding: const EdgeInsets
                                                              .all(15),
                                                          child: Builder(
                                                              builder: (
                                                                  context) {
                                                                if (donations[index]['image'] ==
                                                                    null) {
                                                                  return
                                                                    const CircleAvatar(
                                                                      radius: 30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .account_circle_outlined),
                                                                    );
                                                                }
                                                                else {
                                                                  return CircleAvatar(
                                                                    radius: 30,
                                                                    foregroundImage: NetworkImage(
                                                                        donations[index]['image']),
                                                                    child: const Icon(
                                                                        Icons
                                                                            .account_circle_outlined),
                                                                  );
                                                                }
                                                              }
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  top: 10),
                                                              child: Text(
                                                                donations[index]['user name'],
                                                                style: const TextStyle(
                                                                    fontWeight: FontWeight
                                                                        .bold,
                                                                    fontSize: 18,color: Colors.black),),
                                                            ),
                                                            Text(donations[index]['location'],
                                                                style: TextStyle(
                                                                    fontSize: 14,color: Colors.black)),
                                                            Text(
                                                                donations[index]['phone number'],
                                                                style: const TextStyle(
                                                                    fontSize: 14,color: Colors.black)),
                                                            const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  top: 18),
                                                              child: Text(
                                                                  'Critical',
                                                                  style: TextStyle(
                                                                      fontSize: 14,color: Colors.black)),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left: 10),
                                                              child: Text(
                                                                donations[index]['time'],
                                                                style: const TextStyle(
                                                                    fontSize: 10,color: Colors.black),),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 7),
                                                              child: Text(
                                                                donations[index]['date'],
                                                                style: const TextStyle(
                                                                    fontSize: 10,color: Colors.black),),
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
                                                          CupertinoIcons
                                                              .drop_fill,
                                                          size: 70,
                                                          color: Colors
                                                              .pinkAccent[400],),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(
                                                              top: 22,
                                                              left: 15),
                                                          child: Icon(
                                                            Icons.water_drop,
                                                            color: Colors
                                                                .pinkAccent[400],
                                                            size: 40,),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(
                                                              left: 20,
                                                              top: 27),
                                                          child: SizedBox(
                                                            width: 30,
                                                            height: 30,
                                                            child: Center(
                                                              child: Text(
                                                                donations[index]['blood group'],
                                                                style: const TextStyle(
                                                                    fontSize: 15,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight: FontWeight
                                                                        .bold),),
                                                            ),
                                                          ),
                                                        ),
                                                        Icon(CupertinoIcons
                                                            .drop_fill,
                                                          color: Colors
                                                              .pinkAccent[400],),
                                                      ],),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(right: 10,
                                                              bottom: 10,
                                                              top: 20),
                                                          child: Builder(
                                                            builder: (context) {
                                                              if(donations[index]['status'] == 'pending'){
                                                                return
                                                                  Container(
                                                                      height: 40,
                                                                      width: 100,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius
                                                                              .circular(
                                                                              20),
                                                                          color: Colors
                                                                              .yellow[700]),
                                                                      child: const Center(
                                                                        child: Text(
                                                                          'Pending',
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontWeight: FontWeight
                                                                                  .bold,
                                                                              fontSize: 15),),
                                                                      ));
                                                              }
                                                              else {
                                                                return Container(
                                                                    height: 40,
                                                                    width: 100,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius
                                                                            .circular(
                                                                            20),
                                                                        color: Colors
                                                                            .green[300]),
                                                                    child: const Center(
                                                                      child: Text(
                                                                        'Donated',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize: 15),),
                                                                    ));
                                                              }
                                                            }
                                                          ),
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
                                );
                            },);
                        }
                      }
                    }
                  ),
                  StreamBuilder(
                    stream:  FirebaseFirestore.instance.collection('Requests').snapshots(),
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
                            details.add(
                                {
                                  'user name': element.data()['user name'],
                                  'required date': element
                                      .data()['required date'],
                                  'blood group': element.data()['blood group'],
                                  'phone number': element
                                      .data()['phone number'],
                                  'time': element.data()['time'],
                                  'date': element.data()['date'],
                                  'image': element.data()['image'],
                                  'location': element.data()['location'],
                                  'status': element.data()['status']
                                });
                          }
                        });
                        if (details.isEmpty) {
                          return
                            const Center(
                                child: Text('No Requests Yet'));
                        }
                        else {
                          return ListView.builder(
                            itemCount: details.length,
                            itemBuilder: (context, index) {
                              details.sort((a, b) {
                                var adate = a['date'];
                                var bdate = b['date'];
                                return -adate.compareTo(bdate);
                              });
                              return
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 15, right: 15),
                                  child: Card(
                                    elevation: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: CupertinoColors.white,
                                          borderRadius: BorderRadius.circular(
                                              10)),
                                      height: 170,
                                      child: Stack(
                                          children: [
                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 9),
                                                child: Text(
                                                    'Need Before : ${details[index]['required date']}',
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
                                                          padding: const EdgeInsets
                                                              .all(15),
                                                          child: Builder(
                                                              builder: (
                                                                  context) {
                                                                if (details[index]['image'] ==
                                                                    null) {
                                                                  return
                                                                    const CircleAvatar(
                                                                      radius: 30,
                                                                      child: Icon(
                                                                          Icons
                                                                              .account_circle_outlined),
                                                                    );
                                                                }
                                                                else {
                                                                  return CircleAvatar(
                                                                    radius: 30,
                                                                    foregroundImage: NetworkImage(
                                                                        details[index]['image']),
                                                                    child: const Icon(
                                                                        Icons
                                                                            .account_circle_outlined),
                                                                  );
                                                                }
                                                              }
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  top: 10),
                                                              child: Text(
                                                                details[index]['user name'],
                                                                style: const TextStyle(
                                                                    fontWeight: FontWeight
                                                                        .bold,
                                                                    fontSize: 18,color: Colors.black),),
                                                            ),
                                                            Text(
                                                                details[index]['location'],
                                                                style: const TextStyle(
                                                                    fontSize: 14)),
                                                            Text(
                                                                details[index]['phone number'],
                                                                style: const TextStyle(
                                                                    fontSize: 14,color: Colors.black)),
                                                            const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  top: 18),
                                                              child: Text(
                                                                  'Critical',
                                                                  style: TextStyle(
                                                                      fontSize: 14,color: Colors.black)),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left: 10),
                                                              child: Text(
                                                                details[index]['time'],
                                                                style: const TextStyle(
                                                                    fontSize: 10,color: Colors.black),),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 7),
                                                              child: Text(
                                                                details[index]['date'],
                                                                style: const TextStyle(
                                                                    fontSize: 10,color: Colors.black),),
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
                                                          CupertinoIcons
                                                              .drop_fill,
                                                          size: 70,
                                                          color: Colors
                                                              .pinkAccent[400],),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(
                                                              top: 22,
                                                              left: 15),
                                                          child: Icon(
                                                            Icons.water_drop,
                                                            color: Colors
                                                                .pinkAccent[400],
                                                            size: 40,),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(
                                                              left: 20,
                                                              top: 27),
                                                          child: SizedBox(
                                                            width: 30,
                                                            height: 30,
                                                            child: Center(
                                                              child: Text(
                                                                details[index]['blood group'],
                                                                style: const TextStyle(
                                                                    fontSize: 15,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight: FontWeight
                                                                        .bold),),
                                                            ),
                                                          ),
                                                        ),
                                                        Icon(CupertinoIcons
                                                            .drop_fill,
                                                          color: Colors
                                                              .pinkAccent[400],),
                                                      ],),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(right: 10,
                                                              bottom: 10,
                                                              top: 20),
                                                          child: Builder(
                                                              builder: (context) {
                                                                if(details[index]['status'] == 'pending'){
                                                                  return
                                                                    Container(
                                                                        height: 40,
                                                                        width: 100,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius
                                                                                .circular(
                                                                                20),
                                                                            color: Colors
                                                                                .yellow[700]),
                                                                        child: const Center(
                                                                          child: Text(
                                                                            'Pending',
                                                                            style: TextStyle(
                                                                                color: Colors
                                                                                    .white,
                                                                                fontWeight: FontWeight
                                                                                    .bold,
                                                                                fontSize: 15),),
                                                                        ));
                                                                }
                                                                else {
                                                                  return Container(
                                                                      height: 40,
                                                                      width: 100,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius
                                                                              .circular(
                                                                              20),
                                                                          color: Colors
                                                                              .green[300]),
                                                                      child: const Center(
                                                                        child: Text(
                                                                          'Received',
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontWeight: FontWeight
                                                                                  .bold,
                                                                              fontSize: 15),),
                                                                      ));
                                                                }
                                                              }
                                                          ),
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
                                );
                            },);
                        }
                      }
                    }
                  ),
                ],
              ),
            ),
    );
  }
}
