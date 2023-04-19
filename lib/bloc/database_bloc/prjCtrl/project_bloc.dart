import 'dart:async';
import 'package:flutter_dowith/bloc/database_bloc/model/project/members_list_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_get_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_member_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_set_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_rule_model.dart';

import '../model/project/project_overview_model.dart';
import '../model/user/user_dtl_model.dart';
import 'project_repository.dart';

class ProjectBloc {
  static late int currentProject;
  final ProjectRepository _projectRepository;
  final StreamController<List<ProjectOverViewModel>> _overViewController = StreamController.broadcast();
  final StreamController<List<ProjectOverViewModel>> _myOverViewController = StreamController.broadcast();
  final StreamController<ProjectGetModel> _projectController = StreamController.broadcast();
  final StreamController<List<ProjectRuleModel>> _ruleController = StreamController.broadcast();
  // final StreamController<ProjectMemberModel> _mbrController = StreamController.broadcast();
  final StreamController<List<MembersListModel>> _mbrListController = StreamController.broadcast();

  dispose() {
    _overViewController.close();
    _myOverViewController.close();
    _projectController.close();
  }

  Stream<List<ProjectOverViewModel>> get overViewController => _overViewController.stream;
  Stream<List<ProjectOverViewModel>> get myOverViewController => _myOverViewController.stream;
  Stream<ProjectGetModel> get projectController => _projectController.stream;

  Stream<List<ProjectRuleModel>> get ruleController => _ruleController.stream;
  Stream<List<MembersListModel>> get mbrListController => _mbrListController.stream;

  ProjectBloc(this._projectRepository);

  getOverView(int? page, String? searchKeyword, List<int>? filters, int? sort) async {
    List<ProjectOverViewModel> entireList = await _projectRepository.getProjectList(page, searchKeyword, sort);
    if (filters != null && filters.isNotEmpty) {
      List<ProjectOverViewModel> filteredList = entireList.where((project) => filters.contains(project.category)).toList();
      _overViewController.sink.add(filteredList);
    } else {
      _overViewController.sink.add(entireList);
    }
  }

  getMyOverView(int? userId) async {
    List<ProjectOverViewModel> myList = await _projectRepository.getMyProjectList(userId);
    _myOverViewController.sink.add(myList);
  }

  getCurrentProject(int prjId) async {
    currentProject = prjId;
    ProjectGetModel model = await _projectRepository.getProject(prjId);
    _projectController.sink.add(model);
  }

  getPrjRules() async{
    List<ProjectRuleModel> model = await _projectRepository.getProjectRule(currentProject);
    _ruleController.sink.add(model);
  }

  getMembers() async{
    List<MembersListModel> model = await _projectRepository.getProjectMember(currentProject);
    _mbrListController.sink.add(model);
  }
}
