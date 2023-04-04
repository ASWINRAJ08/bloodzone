
import 'package:bloodzone/BottomNavigation_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'donate_page.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {

  @override
  void initState() {
    getData();
    super.initState();
  }

  var fkey = GlobalKey<FormState>();
  TextEditingController pname = TextEditingController();
  TextEditingController rdate = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController location = TextEditingController();

  String blood = 'Required Blood Group';
  String plus = '+';
  String value = 'gender';
  List<String> elements=['Required Blood Group','A+','B+','AB+','O+','A-','B-','AB-','O-'];
  bool switchValue = false;
  var uid ;
  List details = [];
  var image;

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
                      'name': element.data()['name'],
                      'phone number': element.data()['phone number'],
                      'image':element.data()['image']
                    });
                  }
                });
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    leading: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Navigation(),));
                        },
                        icon: const Icon(CupertinoIcons.arrow_left)),
                    title: Text('Request Blood', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pinkAccent[400]),),
                  ),
                  body: SingleChildScrollView(
                    child: Form(
                      key: fkey,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(15),
                            child: Image(
                                image: AssetImage('Assets/Images/donate.png'),
                                height: 100),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: TextFormField(
                              controller: pname,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Patient's name";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Patient Name',
                                  hintStyle: const TextStyle(fontSize: 14),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Icon(Icons.hotel_outlined,
                                      color: Colors.pinkAccent[400],),
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
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
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
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Icon(Icons.people_outlined,
                                        color: Colors.pinkAccent[400],),
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
                                  const DropdownMenuItem(value: 'gender',
                                      child: Text('Gender')),
                                  DropdownMenuItem(value: 'male',
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Icon(Icons.male_outlined,
                                              color: Colors.pinkAccent[400],),
                                          ),
                                          const Text('Male'),
                                        ],
                                      )),
                                  DropdownMenuItem(value: 'female', child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0),
                                        child: Icon(Icons.female_outlined,
                                          color: Colors.pinkAccent[400],),
                                      ),
                                      const Text('Female'),
                                    ],
                                  )),
                                  DropdownMenuItem(value: 'other', child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0),
                                        child: Icon(Icons.transgender_outlined,
                                          color: Colors.pinkAccent[400],),
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
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: TextFormField(
                              controller: name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Your Name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: 'User Name',
                                  hintStyle: const TextStyle(fontSize: 14),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Icon(Icons.account_circle_outlined,
                                      color: Colors.pinkAccent[400],),
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
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return
                                    'enter your number';
                                }
                              },
                              controller: number,
                              decoration: InputDecoration(
                                  hintText: 'User Mobile Number',
                                  hintStyle: const TextStyle(fontSize: 14),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Icon(Icons.phone_iphone_outlined,
                                      color: Colors.pinkAccent[400],),
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
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: DropdownButtonFormField(
                                validator: (d) {
                                  if (d!.contains('Required Blood Group')) {
                                    return 'Select Required Blood Group';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Required Blood Group',
                                    hintStyle: const TextStyle(fontSize: 14),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Icon(Icons.water_drop_outlined,
                                        color: Colors.pinkAccent[400],),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                    filled: true,
                                    fillColor: Colors.blueGrey[50],
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide.none)
                                ),
                                value: blood,
                                items: elements.map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e),))
                                    .toList(),
                                onChanged: (v) {
                                  setState(() {
                                    blood = v!;
                                  });
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: TextFormField(
                              controller: location,
                              validator: (c) {
                                if (c!.isEmpty) {
                                  return "Enter Patient's Location";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Location',
                                  hintStyle: const TextStyle(fontSize: 14),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Icon(Icons.location_on_outlined,
                                      color: Colors.pinkAccent[400],),
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
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: TextFormField(
                              controller: rdate,
                              validator: (c) {
                                if (c!.isEmpty) {
                                  return 'Select Required Date';
                                }
                                return null;
                              },
                              onTap: () async {
                                FocusScope.of(context).requestFocus(
                                    FocusNode());
                                var pickedDate = await showDatePicker(
                                    builder: (context, child) {
                                      return Theme(data: ThemeData().copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: Colors.pinkAccent.shade400,
                                          onPrimary: Colors.white,
                                          surface: Colors.pinkAccent.shade400,
                                          onSurface: Colors.black,
                                        ),
                                        dialogBackgroundColor: Colors.blueGrey
                                            .shade50,
                                      ), child: child!);
                                    },
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1990, 01, 01),
                                    lastDate: DateTime(2025, 12, 30));
                                rdate.text = DateFormat('dd-MM-yyyy').format(
                                    pickedDate!);
                              },
                              decoration: InputDecoration(
                                  hintText: 'Required Date',
                                  hintStyle: const TextStyle(fontSize: 14),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Icon(Icons.calendar_month_outlined,
                                      color: Colors.pinkAccent[400],),
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
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 60),
                                  child: Text('Critical', style: TextStyle(
                                      color: Colors.pinkAccent[400],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),),
                                ),
                                Switch(
                                  activeColor: Colors.red,
                                  inactiveThumbColor: Colors.pinkAccent[400],
                                  value: switchValue,
                                  onChanged: (value) {
                                    setState(() {
                                      switchValue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 20, top: 20, left: 20, right: 20),
                            child: InkWell(onTap: () async {
                              var time = TimeOfDay.now().format(context);
                              var a = DateTime.now();
                              var date = DateFormat('dd-MM-yyyy').format(a!);
                              if (fkey.currentState!.validate()) {
                                try {
                                  var data = await FirebaseFirestore.instance
                                      .collection("Requests").add({
                                    'image': details[0]['image'],
                                    'pname': pname.text,
                                    'user name': details[0]['name'],
                                    'required date': rdate.text,
                                    'gender': value,
                                    'blood group': blood,
                                    'phone number': details[0]['phone number'],
                                    'time': time,
                                    'date': date,
                                    'id': uid,
                                    'location': location.text,
                                    'status' : 'pending'
                                  });
                                }
                                catch (a) {
                                  if (kDebugMode) {
                                    print(a);
                                  }
                                }
                                await showDialog(
                                    context: context, builder: (context) {
                                  return AlertDialog(title: const Center(
                                      child: Text('Requested')),
                                    content: SizedBox(
                                      height: 100,
                                      child: Lottie.asset(
                                        'Assets/Images/96673-success.json',
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
                                              builder: (context) => Donate(),),
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
                                    'Send Request')),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
      }
    );
  }
}
