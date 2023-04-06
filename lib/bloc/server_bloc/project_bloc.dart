import 'dart:async';

import 'package:flutter_dowith/bloc/server_bloc/model/project_model.dart';
import 'package:flutter_dowith/bloc/server_bloc/project_repository.dart';

class ProjectBloc {
  final ProjectRepository _projectRepository;
  final StreamController<List<ProjectOverViewModel>> _overViewController =
      StreamController<List<ProjectOverViewModel>>.broadcast();
  final StreamController<List<ProjectOverViewModel>> _myOverViewController =
      StreamController<List<ProjectOverViewModel>>.broadcast();

  dispose(){
    _overViewController.close();
    _myOverViewController.close();
  }

  Stream<List<ProjectOverViewModel>> get overViewController => _overViewController.stream;

  ProjectBloc(this._projectRepository);

  getOverView(int? page, String? searchKeyword, List<int>? categories, String? sort) async{
    List<ProjectOverViewModel> entireList = await _projectRepository.getProjectList(page, searchKeyword, categories, sort);
    _overViewController.sink.add(entireList);
  }

  getMyOverView(int userId) async{
    List<ProjectOverViewModel> myList = await _projectRepository.getMyProjectList(userId);
    _myOverViewController.sink.add(myList);
  }
}
