import 'package:flutter/material.dart';

class ProjectDrawUpEditProvider extends ChangeNotifier{
  bool _period = false;
  bool _editable = false;
  bool _isLimit = false;
  DateTime _initDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 1));
  List<String> _ruleList = [];

  void initialize(){
    _period = false;
    _editable = false;
    _isLimit = false;
    _initDate = DateTime.now();
    _endDate = DateTime.now().add(const Duration(days: 1));
    _ruleList.clear();
    notifyListeners();
  }

  bool get period => _period;
  bool get editable => _editable;
  bool get isLimit => _isLimit;
  DateTime get initDate => _initDate;
  DateTime get endDate => _endDate;
  List<String> get ruleList => _ruleList;

  set period(bool value) {
    _period = value;
    notifyListeners();
  }

  set editable(bool value) {
    _editable = value;
    notifyListeners();
  }

  set isLimit(bool value) {
    _isLimit = value;
    notifyListeners();
  }

  set initDate(DateTime value) {
    _initDate = value;
    notifyListeners();
  }

  set endDate(DateTime value) {
    _endDate = value;
    notifyListeners();
  }

  void addList(String value){
    _ruleList.add(value);
    notifyListeners();
  }

  void removeList(int index){
    _ruleList.removeAt(index);
    notifyListeners();
  }

  void ruleLengthCheck(){
    if (_ruleList.length >= 5){
      _isLimit = true;
    } else {
      _isLimit = false;
    }
    notifyListeners();
  }
}