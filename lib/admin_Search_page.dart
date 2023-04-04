import 'package:bloodzone/Profile_Page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'admin_profile_page.dart';

class adsearch extends StatefulWidget {
  const adsearch({Key? key}) : super(key: key);

  @override
  State<adsearch> createState() => _adsearchState();
}

class _adsearchState extends State<adsearch> {

  String searchtxt = "" ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextFormField(
          onChanged: (v){
            setState(() {
              searchtxt = v ;
            });
          },
          decoration: InputDecoration(
              hintText: 'Search Blood Group',
              hintStyle: TextStyle(fontSize: 14,color: Colors.pinkAccent[400]),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Icon(CupertinoIcons.search,color: Colors.pinkAccent[400],),
              ),
              contentPadding: const EdgeInsets.all(10),
              filled: true,
              fillColor: Colors.blueGrey[50],
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none)
          ),
        ),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Users").snapshots(),
              builder:(BuildContext context,snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting && snapshot.hasData != true) {
                  return
                    Center(
                        child: CircularProgressIndicator(
                          color: Colors.pinkAccent[400],
                        ));
                }
                else {
                  return
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                          if(searchtxt.isEmpty) {
                            return
                              ListTile(
                                minVerticalPadding: 10,
                                onTap: () =>
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          adprofile(id: snapshot.data!
                                              .docs[index]['id']),)),
                                leading: Builder(
                                    builder: (context) {
                                      if (snapshot.data!.docs[index]['image'] == null) {
                                        return
                                          const CircleAvatar(
                                            child: Icon(
                                                Icons.account_circle_outlined),
                                          );
                                      }
                                      else {
                                        return CircleAvatar(
                                          foregroundImage: NetworkImage(
                                              snapshot.data!
                                                  .docs[index]['image']),
                                          child: const Icon(
                                              Icons.account_circle_outlined),
                                        );
                                      }
                                    }
                                ),
                                title: Text(snapshot.data!.docs[index]['name']),
                                subtitle: Text(
                                    snapshot.data!.docs[index]['phone number']),
                                trailing: Stack(
                                  children: [
                                    Icon(
                                      CupertinoIcons.drop_fill,
                                      size: 50,
                                      color: Colors.pinkAccent[400],),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 11),
                                      child: Icon(Icons.water_drop,
                                        color: Colors.pinkAccent[400],
                                        size: 30,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 11, top: 16),
                                      child: SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: Center(
                                          child: Text(snapshot.data!
                                              .docs[index]['blood group'],
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight
                                                    .bold),),
                                        ),
                                      ),
                                    ),
                                  ],),
                              );
                          }
                          if(data['phone number'].toString().contains(searchtxt)){
                            return
                              ListTile(
                                minVerticalPadding: 10,
                                onTap: () =>
                                    Navigator.push(
                                        context, MaterialPageRoute(
                                      builder: (context) =>
                                          Profile(id: data['id']),)),
                                leading: Builder(
                                    builder: (context) {
                                      if (data['image'] == null) {
                                        return
                                          const CircleAvatar(
                                            child: Icon(
                                                Icons
                                                    .account_circle_outlined),
                                          );
                                      }
                                      else {
                                        return CircleAvatar(
                                          foregroundImage: NetworkImage(
                                              data['image']),
                                          child: const Icon(
                                              Icons
                                                  .account_circle_outlined),
                                        );
                                      }
                                    }
                                ),
                                title: Text(data['name'],maxLines: 1,overflow: TextOverflow.ellipsis,),
                                subtitle: Text(
                                  data['phone number'],maxLines: 1,overflow: TextOverflow.ellipsis,),
                                trailing: Stack(
                                  children: [
                                    Icon(
                                      CupertinoIcons.drop_fill,
                                      size: 50,
                                      color: Colors.pinkAccent[400],),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 11),
                                      child: Icon(Icons.water_drop,
                                        color: Colors.pinkAccent[400],
                                        size: 30,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 11, top: 16),
                                      child: SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: Center(
                                          child: Text(data['blood group'],
                                            maxLines: 1,overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight
                                                    .bold),),
                                        ),
                                      ),
                                    ),
                                  ],),
                              );
                          }
                          else{
                            return
                              Container();
                          }
                        },),
                    );
                }
              }),
        ],
      ),
    );
  }
}
