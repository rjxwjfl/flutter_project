import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/members_list_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_member_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_repository.dart';
import 'package:flutter_dowith/bloc/database_bloc/userCtrl/user_repository.dart';
import 'package:flutter_dowith/main.dart';

class UserManagementProvider extends ChangeNotifier{
  static int? _userId = prefs.getInt("user_id");
  static int? _currentPrjId;
  int? _userRole;
  List<MembersListModel>? _mbrList;

  int? get userId => _userId;
  int? get currentPrjId => _currentPrjId;
  int? get userRole => _userRole;


  List<MembersListModel>? get mbrList => _mbrList;

  set userId(int? value) {
    _userId = value;
    notifyListeners();
  }

  set currentPrjId(int? value) {
    _currentPrjId = value;
    notifyListeners();
  }

  Future<void> fetchUserRole(int prjId) async {
    if (_userId == null){
      _userRole = 3;
      return;
    }
    _currentPrjId = prjId;
    ProjectMemberModel model = await UserRepository().getUserRole(prjId, _userId!);
    _userRole = model.role;
    fetchMemberList();
    notifyListeners();
  }

  Future<void> fetchMemberList() async{
    List<MembersListModel> data = await ProjectRepository().getProjectMember(_currentPrjId!);
    _mbrList = data;
    notifyListeners();
  }

  String intToString() {
    String result;
    const map = {0: "프로젝트장", 1: "관리자", 2: "구성원", 3: "손님"};
    result = map[_userRole] ?? "손님";
    return result;
  }

}
