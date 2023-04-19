import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_rule_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_set_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_repository.dart';
import 'package:flutter_dowith/firebase/auth.dart';
import 'package:flutter_dowith/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectDrawUpEditProvider extends ChangeNotifier {
  bool _period = false;
  bool _editable = false;
  bool _isLimit = false;
  bool _isPrivate = false;
  DateTime _initDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 1));
  int? _selectedCategory;
  List<String> _ruleList = [];
  List<bool> _gridSwitch = List.filled(6, false);
  final ProjectRepository _repository = ProjectRepository();

  final Map<String, IconData> _category = {
    "TEAM-WORK": FontAwesomeIcons.users,
    "STUDY": FontAwesomeIcons.pencil,
    "EXERCISE": FontAwesomeIcons.dumbbell,
    "HOBBIES": FontAwesomeIcons.icons,
    "DEVELOP": FontAwesomeIcons.code,
    "ETC": FontAwesomeIcons.question
  };

  void initialize() {
    _period = false;
    _editable = false;
    _isLimit = false;
    _isPrivate = false;
    _initDate = DateTime.now();
    _endDate = DateTime.now().add(const Duration(days: 1));
    _selectedCategory = null;
    _ruleList.clear();
    _gridSwitch = List.filled(6, false);
    notifyListeners();
  }

  bool get period => _period;

  bool get editable => _editable;

  bool get isLimit => _isLimit;

  bool get isPrivate => _isPrivate;

  DateTime get initDate => _initDate;

  DateTime get endDate => _endDate;

  int? get selectedCategory => _selectedCategory;

  Map<String, IconData> get category => _category;

  List<String> get ruleList => _ruleList;

  List<bool> get gridSwitch => _gridSwitch;

  set period(bool value) {
    _period = value;
    notifyListeners();
  }

  set isPrivate(bool value) {
    _isPrivate = value;
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

  void addList(String value) {
    _ruleList.add(value);
    notifyListeners();
  }

  void removeList(int index) {
    _ruleList.removeAt(index);
    notifyListeners();
  }

  void ruleLengthCheck() {
    if (_ruleList.length >= 5) {
      _isLimit = true;
    } else {
      _isLimit = false;
    }
    notifyListeners();
  }

  void setCategory(int index) {
    if (_selectedCategory != null) {
      _gridSwitch = List.filled(6, false);
      _selectedCategory = null;
    }
    _gridSwitch[index] = true;
    _selectedCategory = index;
    notifyListeners();
  }

  void drawUp(String title, String prjDesc, String goal, bool pvt) async {
    int mstId;
    ProjectSetModel model;
    if (Auth().auth.currentUser == null) {
      print("로그인되지 않음");
      return;
    }
    if (prefs.getInt("user_id") == null) {
      return;
    }
    mstId = prefs.getInt("user_id")!;
    model = ProjectSetModel(
        title: title,
        category: _selectedCategory!,
        prjDesc: prjDesc,
        goal: goal,
        pvt: pvt);
    if(_period){
      model.startOn = _initDate;
      model.expireOn = _endDate;
    }
    await _repository.createProject(mstId, model);
  }
}