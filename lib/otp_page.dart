import 'package:bloodzone/BottomNavigation_page.dart';
import 'package:bloodzone/Registration_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Authentication_Class.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {

  @override

  void initState() {
    registerUser(plus+Data.phonecode+Data.phonenumber.text,context);
    super.initState();
  }

  var id ;
  var otp ;
  String plus = '+';
  String? vcode;
  FirebaseAuth auth = FirebaseAuth.instance;
  List number = [] ;

  Future registerUser(String mobile, BuildContext context) async{

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: plus+Data.phonecode+Data.phonenumber.text,

      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      },

      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {

        setState(() {
          vcode = verificationId;
        });

      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> saveData() async {
    SharedPreferences spname = await SharedPreferences.getInstance();
    spname.setString('id', id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Users').snapshots(),
          builder: (context, snapshot) {
            return Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(Icons.cloud_done,color: Colors.pinkAccent[400]),
                      ),
                      const Text('Verification Code',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 90),
                  child: Center(child: Text('We will send you a verification code on your phone')),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: OtpTextField(
                    onSubmit: (String verificationCode){
                      setState(() {
                        otp = verificationCode;
                      });
                    },
                    keyboardType: TextInputType.number,
                    numberOfFields: 6,
                    focusedBorderColor: Colors.pinkAccent.shade400,
                    cursorColor: Colors.pinkAccent.shade400,
                    fillColor: Colors.blueGrey.shade50,
                    filled: true,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 200,top: 80,left: 20,right: 20),
                    child: InkWell(onTap: () async{

                            String smsCode = otp;

                            PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: vcode!, smsCode: smsCode);
                            var user = await auth.signInWithCredential(credential);

                            id = user.user?.uid ;

                            await saveData();

                                  snapshot.data!.docs.forEach((element) async {
                                  if (element.data()['phone number'] == plus+Data.phonecode+Data.phonenumber.text) {
                                    number.add(plus + Data.phonecode +
                                        Data.phonenumber.text);
                                  }
                                  });

                                    if(number.isNotEmpty){

                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  Fluttertoast.showToast(msg: 'Signed In');
                                  return
                                  const Navigation();
                                },));
                                  }

                              else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  Fluttertoast.showToast(msg: 'Verified');
                                  return
                                  const Registration();
                                },));
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
              ],
            );
          }
        ),
      ),
    );
  }
}
