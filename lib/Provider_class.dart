import 'package:flutter/material.dart';

class Thememode extends ChangeNotifier{

  Brightness a = Brightness.light;
  int count = 0 ;

  void change(){
    count++ ;
    if(count == 1) {
      a = Brightness.dark;
      notifyListeners();
    }
    else{
      count = 0 ;
      a = Brightness.light;
      notifyListeners();
    }
  }
}