import 'dart:async';
import 'package:flutter_dowith/main.dart';

import '../model/project/project_overview_model.dart';
import '../model/user/user_dtl_model.dart';
import 'project_repository.dart';

class ProjectBloc {
  final ProjectRepository _projectRepository;
  final StreamController<List<ProjectOverViewModel>> _overViewController =
      StreamController<List<ProjectOverViewModel>>.broadcast();
  final StreamController<List<ProjectOverViewModel>> _myOverViewController =
      StreamController<List<ProjectOverViewModel>>.broadcast();
  final StreamController<UserDtlModel> _userDtlController = StreamController.broadcast();

  dispose() {
    _overViewController.close();
    _myOverViewController.close();
    _userDtlController.close();
  }

  Stream<List<ProjectOverViewModel>> get overViewController => _overViewController.stream;
  Stream<List<ProjectOverViewModel>> get myOverViewController => _myOverViewController.stream;


  Stream<UserDtlModel> get userDtlController => _userDtlController.stream;

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

  getUserDtlInfo(int userId) async {
    UserDtlModel model = await _projectRepository.getUser(userId);
    _userDtlController.sink.add(model);
  }
}
