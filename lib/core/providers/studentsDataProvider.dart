import 'package:flutter/material.dart';

class StudentDataProvider with ChangeNotifier {
  Map _profile = {};
  Map get profile => _profile;

  List _appointments = [];
  get appointments => _appointments;

  List _doctors = [];
  get doctors => _doctors;

  void setData(value) {
    _profile = value['user'];
    _appointments = value['appointments'];
    _doctors = value['doctors'];
    notifyListeners();
  }
}
