
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Authentication_Class.dart';
import 'otp_page.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  GlobalKey<FormState> fkey = GlobalKey();
  dynamic flag1 ;
  String plus = '+';
  TextEditingController countryname = TextEditingController();

  countryPick() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
          bottomSheetHeight: 500,
          backgroundColor: Colors.blueGrey[50],
        borderRadius: BorderRadius.zero,
        flagSize: 20,
        inputDecoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: Icon(CupertinoIcons.search),
          ),
            hintText: 'Search Your Country',
          filled: true,
            fillColor: Colors.blueGrey[100],
            contentPadding: const EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(30)) ),
      ),
      onSelect: (Country country) {
        countryname.text = country.name.toString();
        flag1 = country.flagEmoji;
        Data.phonecode = country.phoneCode;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: fkey,
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 80),
              child: SizedBox(
                height: 200,
                width: 200,
                child: Image(image: AssetImage('Assets/Images/bloodzone.png')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 140),
              child: SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                      child: TextFormField(
                        controller: countryname,
                        validator: (a) {
                          if(a!.isEmpty){
                            return 'Select Your Contry';
                          }
                          return null;
                        },
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          countryPick();
                        },
                        decoration: InputDecoration(
                            hintText: 'Select Your Country',
                            hintStyle: const TextStyle(fontSize: 14),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20),
                              child: Builder(builder: (context) {
                                if(flag1 == null){
                                  return
                                      Icon(Icons.flag_outlined,color: Colors.pinkAccent[400],);
                                }
                                else {
                                  return
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Text(flag1,style: const TextStyle(fontSize: 18),),
                                  );
                                }
                              },)
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
                      padding: const EdgeInsets.only(left: 20,right: 20),
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
                              child: Builder(
                                builder: (context) {
                                  if(Data.phonecode == null) {
                                    return Icon(Icons.phone_iphone_outlined,
                                      color: Colors.pinkAccent[400],);
                                  }
                                  else{
                                    return
                                        Padding(
                                          padding: const EdgeInsets.only(top: 12),
                                          child: Text(plus+Data.phonecode,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                        );
                                  }
                                }
                              ),
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
                        padding: const EdgeInsets.only(bottom: 20,top: 100,left: 20,right: 20),
                        child: InkWell(onTap: () {
                          if(fkey.currentState!.validate()) {

                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Otp(),));
                            Fluttertoast.showToast(msg: 'Enter OTP');

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
                                'SIGN IN')),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("BLOODZONE",style: TextStyle(
                    color: Colors.pinkAccent[400],
                    fontWeight: FontWeight.bold,
                      fontSize: 18),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
