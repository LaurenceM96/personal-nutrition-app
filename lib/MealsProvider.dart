import 'dart:collection';

import 'package:flutter/cupertino.dart';

class MealsProvider with ChangeNotifier {

  //Map _allMeals = {};
  Map _allMeals = {'coco pops': '500,2.5', 'apricot': '100,1.5'};

  UnmodifiableMapView get getAllMeals => UnmodifiableMapView(_allMeals);

  void addMeal(String mealName, String caloriesProtein) {
    //Should probs do some validation here on caloriesProtien and make sure meal doesn't already exist
    _allMeals[mealName] = caloriesProtein;
    notifyListeners();
  }

  void removeMeal(String meal) {
    _allMeals.remove(meal);
    notifyListeners();
  }

  void clearMeals() {
    _allMeals.clear();
    notifyListeners();
  }

}