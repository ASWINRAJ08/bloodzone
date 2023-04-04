import 'package:flutter/material.dart';

import 'BottomNavigation_page.dart';

class Adhospital extends StatefulWidget {
  const Adhospital({Key? key}) : super(key: key);

  @override
  State<Adhospital> createState() => _AdhospitalState();
}

class _AdhospitalState extends State<Adhospital> {
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
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: FloatingActionButton(onPressed: () async {
                          await showDialog(context: context, builder: (context){
                          return
                          AlertDialog(title: const Center(
                          child: Text('Requested')),content: SizedBox(
                              height: 100,
                              child: Icon(Icons.done,color: Colors.pinkAccent[400],size: 80,),
                              ),
                            actions: [
                                Center(child: TextButton(
                                onPressed: () =>
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Navigation(),)),
                                    child: const Text('Done')))],
                          );
                          }
                          );
                          },
                      child: Icon(Icons.add,color: Colors.pinkAccent[400],),
              ),
            ),
          ]
    ),
    );
  }
}
