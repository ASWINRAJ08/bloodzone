import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feedbackpage extends StatefulWidget {
  const Feedbackpage({Key? key}) : super(key: key);

  @override
  State<Feedbackpage> createState() => _Feedbackpage();
}

class _Feedbackpage extends State<Feedbackpage> {

  TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback',style: TextStyle(color: Colors.pinkAccent[400],fontWeight: FontWeight.bold),),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,bottom: 50),
                    child: Card(
                        elevation: 5,
                        child: SizedBox(
                          height: 250,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: TextField(
                                    controller: text,
                                    decoration: const InputDecoration(
                                        hintText: 'Enter Your Opinions',
                                            border: InputBorder.none
                                    ),
                                  ),
                                ),
                                Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(Icons.star,color: Colors.yellow[700]),
                                    Icon(Icons.star_border,color: Colors.yellow[700]),
                                    Icon(Icons.star_border,color: Colors.yellow[700]),
                                    Icon(Icons.star_border,color: Colors.yellow[700]),
                                    Icon(Icons.star_border,color: Colors.yellow[700])
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 20, top: 60, left: 20, right: 20),
              child: InkWell(onTap: () { },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.pinkAccent[400],
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(child: Text(
                      style: TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.white),
                      'Submit')),
                ),
              ),
            ),
          ]
      ),
    );
  }
}
