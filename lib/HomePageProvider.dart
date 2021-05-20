import 'package:flutter/cupertino.dart';

class HomePageProvider with ChangeNotifier {
  //I was going to use this for restructuring all of the menu but didn't, so now I'm just keeping it as a boilerplate
  //because I'll probs use it for the consumed meals and meals lists so those variables can be accessed
  //across the pages without giving them global access.

  bool _menuVisibility = false;

  bool get getMenuVisibility => _menuVisibility;

  set setMenuVisibility(bool newValue) {
    _menuVisibility = newValue;
    notifyListeners();
  }

}