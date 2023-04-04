import 'package:flutter/material.dart';

class Hospitals extends StatefulWidget {
  const Hospitals({Key? key}) : super(key: key);

  @override
  State<Hospitals> createState() => _HospitalsState();
}

class _HospitalsState extends State<Hospitals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return
                    Padding(
                      padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                      child: Card(
                          elevation: 5,
                          child: Container(
                            height: 150,
                          )
                      ),
                    );
                },
              ),
            ),
          ]
      ),
    );
  }
}
