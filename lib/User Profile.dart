import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BottomNavigation_page.dart';


class Edit extends StatefulWidget {
  const Edit({Key? key}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}
class _EditState extends State<Edit> {

  @override
  void initState() {
    getData();
    super.initState();
  }

  var fkey = GlobalKey<FormState>();
  var uid ;
  var lat ;
  var long ;

  var name ;
  var email ;
  var location ;
  var number ;
  var docid;

  XFile? pickedFile ;
  File? image;
  String? url;
  String plus = '+';

  List details = [];

  Future imagePick() async {
    ImagePicker picker = ImagePicker();
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedFile!.path);
    });

    try{

      var ref = FirebaseStorage.instance.ref().child("image/${image!.path}");
      EasyLoading.show(status: 'uploading image');
      await ref.putFile(image!);
      url = await ref.getDownloadURL();
      EasyLoading.dismiss();
      print(url);
    }
    catch(a){
      if (kDebugMode) {
        print(a);
      }
    }
  }

  Future<void> getData()async {
    SharedPreferences spname = await SharedPreferences.getInstance();
    uid = spname.getString('id');
    print(uid);
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
        details.clear();
        snapshot.data!.docs.forEach((element) {
          if (element.data()['id'] == uid) {
            docid = element.id ;
            details.add({
              'image': element.data()['image'],
              'name': element.data()['name'],
              'phone number': element.data()['phone number'],
              'location': element.data()['location'],
              'email': element.data()['email']
            });
          }
        });
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Form(
              key: fkey,
              child: SafeArea(
                child: Column(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text('EDIT YOUR DETAILS',style: TextStyle(color: Colors.pinkAccent[400],fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30,bottom: 15),
                        child: InkWell(
                          onTap: () async {
                            await imagePick();
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.blueGrey[50],
                            radius: 50,
                            child: Builder(
                              builder: (BuildContext context) {
                                if(image==null) {
                                  return
                                    CircleAvatar(
                                      radius: 50,
                                        backgroundImage: NetworkImage(details[0]['image'])
                                    );
                                }
                                else{
                                  return
                                    CircleAvatar(
                                      radius: 50,
                                        backgroundImage: FileImage(File(pickedFile!.path)));
                                }
                              },)
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Text('Change Image'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.words,
                          initialValue: details[0]['name'],
                          onChanged: (value) {
                            name = value ;
                          },
                          validator: (a) {
                            if(a!.isEmpty){
                              return 'Enter Your Name' ;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: const TextStyle(fontSize: 14),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: Icon(Icons.account_circle_outlined,color: Colors.pinkAccent[400],),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              filled: true,
                              fillColor: Colors.blueGrey[50],
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none)
                          ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                        child: TextFormField(
                          onChanged: (value) {
                            email = value ;
                          },
                          initialValue: details[0]['email'],
                          validator: (b) {
                            if(b!.isEmpty){
                              return 'Enter Your Email' ;
                            }
                            if(b.endsWith('@gmail.com')){
                              return null ;
                            }
                            else{
                              return 'Invalid Email Address' ;
                            }
                          },
                          decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: const TextStyle(fontSize: 14),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: Icon(Icons.mail_outline,color: Colors.pinkAccent[400],),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              filled: true,
                              fillColor: Colors.blueGrey[50],
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none)
                          ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                        child: TextFormField(
                          onChanged: (value) {
                            location = value ;
                          },
                          initialValue: details[0]['location'],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Location';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Location',
                              hintStyle: const TextStyle(fontSize: 14),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: Icon(Icons.location_on_outlined,color: Colors.pinkAccent[400],),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              filled: true,
                              fillColor: Colors.blueGrey[50],
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                        child: TextFormField(
                          onChanged: (value) {
                            number = value;
                          },
                          initialValue: details[0]['phone number'],
                          validator: (b) {
                            if(b!.isEmpty){
                              return 'Enter Your Phone Number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Mobile Number',
                              hintStyle: const TextStyle(fontSize: 14),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: Icon(Icons.phone_iphone_outlined,color: Colors.pinkAccent[400],),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              filled: true,
                              fillColor: Colors.blueGrey[50],
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none)
                          ),),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 20,top: 60,left: 20,right: 20),
                          child: InkWell(onTap: () async {
                            if(fkey.currentState!.validate()) {
                              try {
                                var data = await FirebaseFirestore.instance.collection("Users");
                                data.doc(docid).update({
                                  'name': name,
                                  'email': email,
                                  'image': url,
                                  'location': location,
                                  'phone number': number,
                                });
                              }
                              catch (a) {
                                if (kDebugMode) {
                                  print(a);
                                }
                              }
                              Fluttertoast.showToast(msg: 'Success');
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Navigation(),));
                            }
                          },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.pinkAccent[400],
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Center(child: Text(
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: CupertinoColors.white),
                                  'SUBMIT')),
                            ),
                          )
                      ),
                    ]),
              ),
            ),
          ),
        );
      }
    );
  }
}