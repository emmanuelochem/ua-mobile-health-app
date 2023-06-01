import 'package:flutter/material.dart';

class DoctorDataProvider with ChangeNotifier {
  Map _profile = {};
  Map get profile => _profile;

  List _appointments = [];
  get appointments => _appointments;

  final List _students = [];
  get students => _students;

  void setData(value) {
    _profile = value['profile'];
    _appointments = value['appointments'];
    //_doctors = value['students'];
    notifyListeners();
  }
}
