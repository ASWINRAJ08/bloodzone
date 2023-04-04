import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Message_page.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  @override
  void initState() {
    getData();
    super.initState();
  }

  var uid ;
  List details = [];

  Future<void> getData() async {
    SharedPreferences spname = await SharedPreferences.getInstance();
    uid = spname.getString('id');
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
                    });
                  }
                });
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    leading: Builder(
                        builder: (context) {
                          if (details[0]['image'] == null) {
                            return
                              const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child:
                                  CircleAvatar(
                                    child: Icon(
                                        Icons.account_circle_outlined),
                                  )
                              );
                          }
                          else {
                            return Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child:
                                CircleAvatar(
                                  foregroundImage: NetworkImage(
                                      details[0]['image']),
                                  onForegroundImageError: (exception,
                                      stackTrace) =>
                                  const Icon(CupertinoIcons.person),
                                  child: const Icon(
                                      Icons.account_circle_outlined),
                                )
                            );
                          }
                        }
                    ),
                    title: Text(details[0]['name'] !,
                        style: TextStyle(color: Colors.pinkAccent[400],
                            fontWeight: FontWeight.bold)),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  body: StreamBuilder(
                    stream: null,
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: ListView.builder(
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return
                                ListTile(
                                  onTap: () {

                                  },
                                  leading: const CircleAvatar(),
                                  title: const Text('Name'),
                                  subtitle: const Text('message'),
                                );
                            },),
                        );
                      }
                      else{
                        return
                            const Center(
                                child: Text('No Messages Yet'));
                      }
                    }
                  ),
                );
              }
            }
    );
  }
}
