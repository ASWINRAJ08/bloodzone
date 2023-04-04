import 'dart:io';

import 'package:bloodzone/BottomNavigation_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication_Class.dart';


class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}
class _RegistrationState extends State<Registration> {

  @override
  void initState() {
    getData();
    super.initState();
  }

  var fkey = GlobalKey<FormState>();
  var uid ;
  var lat ;
  var long ;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController location = TextEditingController();

  XFile? pickedFile ;
  File? image;
  String? url;
  String plus = '+';
  String blood = 'Blood Group';
  String value = 'gender';
  List<String> elements = ['Blood Group','A+','B+','AB+','O+','A-','B-','AB-','O-'];

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: fkey,
          child: SafeArea(
            child: Column(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text('ENTER YOUR DETAILS',style: TextStyle(color: Colors.pinkAccent[400],fontWeight: FontWeight.bold)),
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
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1),
                          itemBuilder: (context, index) {
                          if(image==null) {
                            return
                              const Icon(Icons.add_a_photo_outlined);
                          }
                          else{
                            return
                              CircleAvatar(
                                  backgroundImage: FileImage(File(pickedFile!.path)));
                          }
                        },),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text('Upload Image'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: name,
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
                      controller: email,
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
                        controller: location,
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
                      controller: dob,
                      validator: (c) {
                        if (c!.isEmpty) {
                          return 'Select Your D O B';
                        }
                        return null;
                      },
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        var pickedDate = await showDatePicker(
                          builder: (context, child) {
                            return Theme(data: ThemeData().copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Colors.pinkAccent.shade400,
                                onPrimary: Colors.white,
                                surface: Colors.pinkAccent.shade400,
                                onSurface: Colors.black,
                              ),
                              dialogBackgroundColor:Colors.blueGrey.shade50,
                            ), child: child!);

                          },
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1960,01,01),
                            lastDate: DateTime(2030,12,31));
                        dob.text = DateFormat('dd-MM-yyyy').format(pickedDate!);
                      },
                      decoration: InputDecoration(
                          hintText: 'D O B',
                          hintStyle: const TextStyle(fontSize: 14),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20),
                            child: Icon(Icons.calendar_month_outlined,color: Colors.pinkAccent[400],),
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
                    child: DropdownButtonFormField(
                        validator: (d) {
                          if (d!.contains('gender')) {
                            return 'Select Your Gender';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Gender',
                            hintStyle: const TextStyle(fontSize: 14),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20),
                              child: Icon(Icons.people_outlined,color: Colors.pinkAccent[400],),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            filled: true,
                            fillColor: Colors.blueGrey[50],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none)
                        ),
                        value: value,
                        items: [
                          const DropdownMenuItem(value: 'gender', child: Text('Gender')),
                          DropdownMenuItem(value: 'male', child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.male_outlined,color: Colors.pinkAccent[400],),
                              ),
                              const Text('Male'),
                            ],
                          )),
                          DropdownMenuItem(value: 'female', child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.female_outlined,color: Colors.pinkAccent[400],),
                              ),
                              const Text('Female'),
                            ],
                          )),
                          DropdownMenuItem(value: 'other', child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.transgender_outlined,color: Colors.pinkAccent[400],),
                              ),
                              const Text('Other'),
                            ],
                          )),
                        ],
                        onChanged: (v) {
                          setState(() {
                            value = v!;
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                    child: DropdownButtonFormField(
                        validator: (d) {
                          if (d!.contains('Blood Group')) {
                            return 'Select Your Blood Group';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Blood Group',
                            hintStyle: const TextStyle(fontSize: 14),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20),
                              child: Icon(Icons.water_drop_outlined,color: Colors.pinkAccent[400],),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            filled: true,
                            fillColor: Colors.blueGrey[50],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none)
                        ),
                        value: blood,
                        items: elements.map((e) => DropdownMenuItem(value: e,child: Text(e),)).toList(),
                        onChanged: (v) {
                          setState(() {
                            blood = v!;
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                    child: TextFormField(
                      controller: Data.phonenumber,
                      validator: (b) {
                        if(b!.isEmpty){
                          return 'Enter Your Phone Number';
                        }
                        if(b.length<10 || b.length>10) {
                          return 'Invalid Phone Number' ;
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
                            var data = await FirebaseFirestore.instance.collection("Users").add({
                              'name': name.text,
                              'email': email.text,
                              'image': url,
                              'date of birth': dob.text,
                              'gender': value,
                              'blood group': blood,
                              'location': location.text,
                              'phone number': plus+Data.phonecode+Data.phonenumber.text,
                              'id': uid,
                              'location': location.text,
                            });
                          }
                          catch (a) {
                            if (kDebugMode) {
                              print(a);
                            }
                          }
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => const Navigation()));
                          Fluttertoast.showToast(msg: 'Success');
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
}
