import 'dart:collection';

import 'package:flutter/cupertino.dart';

class ConsumedMealsProvider with ChangeNotifier {

  //List _consumedMeals = new List.generate(0, (index) => null);
  List<String> _consumedMeals = ['coco pops', 'apricot'];

  UnmodifiableListView<String> get getConsumedMeals => UnmodifiableListView(_consumedMeals);

  void addConsumedMeal(String meal) {
    _consumedMeals.add(meal);
    notifyListeners();
  }

  void removeConsumedMeal(String meal) {
    _consumedMeals.remove(meal);
    notifyListeners();
  }

  void removeAllConsumedMeals() {
    _consumedMeals.clear();
    notifyListeners();
  }

}