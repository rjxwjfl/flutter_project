import 'dart:async';

import 'package:flutter_dowith/bloc/database_bloc/model/project/project_member_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/user/user_dtl_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/userCtrl/user_repository.dart';

class UserBloc{
  final UserRepository _repository;
  final StreamController<UserDtlModel> _userDtlController = StreamController.broadcast();
  final StreamController<ProjectMemberModel> _roleController = StreamController.broadcast();

  Stream<UserDtlModel> get userDtlController => _userDtlController.stream;
  Stream<ProjectMemberModel> get roleController => _roleController.stream;

  void dispose(){
    _userDtlController.close();
  }

  UserBloc(this._repository);

  getUserDtlInfo(int userId) async {
    UserDtlModel model = await _repository.getUserDtl(userId);
    _userDtlController.sink.add(model);
  }

  getUserRole(int prjId, int userId)async{
    ProjectMemberModel model = await _repository.getUserRole(prjId, userId);
    _roleController.sink.add(model);
  }
}