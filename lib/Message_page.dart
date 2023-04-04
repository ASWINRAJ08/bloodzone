import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  var id;
  Messages({Key? key, required this.id}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

  List details = [];
  var uid ;
  var message ;

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
            uid = widget.id;
            details.clear();
            snapshot.data!.docs.forEach((element) {
              if (element.data()['id'] == uid) {
                details.add({
                  'image': element.data()['image'],
                  'name': element.data()['name'],
                  'id': element.data()['id']
                });
              }
            });
            return Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Builder(
                      builder: (context) {
                        if(details[0]['image']==null){
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
                                details[0]['image']),
                            child: const Icon(Icons.account_circle_outlined),
                          );
                        }
                      }
                  ),
                ),
                title: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(details[0]['name'], style: const TextStyle(fontSize: 19),),
                    const Text('Online', style: TextStyle(fontSize: 11),),
                  ],
                ),
              ),
              body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      shape: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(6)),
                      child: const SizedBox(
                          height: 20,
                          width: 50,
                          child: Center(child: Text('Today'))),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              onChanged: (value) {
                                message = value ;
                              },
                              decoration: InputDecoration(
                                  suffixIcon: Row(mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(onPressed: () {},
                                        icon: Icon(CupertinoIcons.mic,
                                          color: Colors.pinkAccent[400],),),
                                      IconButton(onPressed: () {},
                                        icon: Icon(CupertinoIcons.camera,
                                          color: Colors.pinkAccent[400],),),
                                    ],
                                  ),
                                  hintText: 'Message',
                                  hintStyle: TextStyle(fontSize: 14,
                                    color: Colors.pinkAccent[400],),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 15),
                                    child: Icon(Icons.emoji_emotions_outlined,
                                      color: Colors.pinkAccent[400],),
                                  ),
                                  contentPadding: const EdgeInsets.all(1),
                                  filled: true,
                                  fillColor: Colors.blueGrey[50],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none)
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: FloatingActionButton(
                            shape: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)),
                            onPressed: () {

                            },
                            backgroundColor: Colors.pinkAccent[400],
                            child:   const Icon(Icons.send,color: Colors.white,)
                          ),
                        )
                      ],
                    ),
                  ]),
            );
          }
      }
    );
  }
}
