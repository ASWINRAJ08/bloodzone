import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider_class.dart';

class Settingspage extends StatelessWidget {
  const Settingspage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
            padding: const EdgeInsets.all(20),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dark Mode'),
                FloatingActionButton(onPressed: (){
                  Provider.of<Thememode>(context , listen: false).change();
                }, child: const Icon(Icons.change_circle_outlined)),
              ],
            ),
              )
          ],
        ),
      ),
    );
  }
}