import 'package:flutter/material.dart';

class ItemCounterGreens with ChangeNotifier {
  int counter = 0;
  int get count => counter;

  void increment(List<int> greens) {
    counter++;
    greens.add(counter);
    notifyListeners();
  }
}
