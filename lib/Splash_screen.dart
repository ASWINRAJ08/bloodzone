import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SignIn_page.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _Splashscreen();
}

class _Splashscreen extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 1),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const Signin())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Center(
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: ZoomIn(
                      animate: true,
                      duration: const Duration(seconds: 1), child: Image.asset('Assets/Images/bloodzone.png'),
                ),
              ),
            ),
    ),
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: ZoomIn(
                animate: true,
                duration: const Duration(seconds: 1),
                child: Text('BLOODZONE',
                  style: TextStyle(
                      color: Colors.pinkAccent[400],fontSize: 25,fontWeight: FontWeight.bold),),
              ),
            )
          ],
        )
    );
  }
}
