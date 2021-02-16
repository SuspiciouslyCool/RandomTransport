import 'package:flutter/material.dart';

class Changes with ChangeNotifier {
  int _changes=1;

  int get changes=>_changes;

  void setChanges(int changes) {
    _changes=changes;
    notifyListeners();
  }
  
  void decrement() {
    _changes--;
    notifyListeners();
  }
}