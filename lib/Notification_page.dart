import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notify extends StatefulWidget {
  const Notify({Key? key}) : super(key: key);

  @override
  State<Notify> createState() => NotifyState();
}

class NotifyState extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications',
          style: TextStyle(color: Colors.pinkAccent[400],fontWeight: FontWeight.bold),),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
        return
            const ListTile(
              title: Text('Notification'),
            );
      },),
    );
  }
}
