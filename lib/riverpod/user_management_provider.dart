import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_member_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/userCtrl/user_repository.dart';
import 'package:flutter_dowith/main.dart';

class UserManagementProvider extends ChangeNotifier{
  static int? _userId;
  static int? _currentPrjId;
  late int _userRole;

  int? get userId => _userId;
  int? get currentPrjId => _currentPrjId;
  int get userRole => _userRole;


  set userId(int? value) {
    _userId = value;
    notifyListeners();
  }

  set currentPrjId(int? value) {
    _currentPrjId = value;
    notifyListeners();
  }

  Future<int> fetchUserRole(int prjId) async {
    _userId = prefs.getInt("user_id");
    if (_userId == null){
      _userRole = 3;
      return _userRole;
    }
    _currentPrjId = prjId;

    ProjectMemberModel? model = await UserRepository().getUserRole(prjId, _userId!);
    if (model == null){
      _userRole = 3;
      return _userRole;
    }
    _userRole = model.role;
    notifyListeners();
    return _userRole;
  }

  String intToString() {
    String result;
    const map = {0: "프로젝트장", 1: "관리자", 2: "구성원", 3: "손님"};
    result = map[_userRole] ?? "손님";
    return result;
  }
}
