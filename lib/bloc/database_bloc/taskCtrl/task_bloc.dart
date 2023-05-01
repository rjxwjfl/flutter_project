import 'dart:async';

import 'package:flutter_dowith/bloc/database_bloc/model/task/task_assigned_view.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/task/task_view_compact_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/taskCtrl/task_repository.dart';

class TaskBloc {
  final TaskRepository _taskRepository;
  List<TaskViewCompactModel> _taskList = [];
  List<TaskViewCompactModel> _userTask = [];
  final StreamController<List<TaskAssignedCompactView>> _getPrjUserTaskCtrl = StreamController.broadcast();
  final StreamController<List<TaskAssignedCompactView>> _getUserTaskAllCtrl = StreamController.broadcast();
  final StreamController<List<TaskViewCompactModel>> _getTaskOriCtrl = StreamController.broadcast();
  final StreamController<List<TaskViewCompactModel>> _getMyTaskListCtrl = StreamController.broadcast();
  final StreamController<List<TaskViewCompactModel>> _getFavTaskCtrl = StreamController.broadcast();


  TaskBloc(this._taskRepository);

  Stream<List<TaskAssignedCompactView>> get getPrjUserTaskCtrl => _getPrjUserTaskCtrl.stream;
  Stream<List<TaskAssignedCompactView>> get getUserTaskAllCtrl => _getUserTaskAllCtrl.stream;
  Stream<List<TaskViewCompactModel>> get getTaskOriCtrl => _getTaskOriCtrl.stream;
  Stream<List<TaskViewCompactModel>> get getMyTaskListCtrl => _getMyTaskListCtrl.stream;
  Stream<List<TaskViewCompactModel>> get getFavTaskCtrl => _getFavTaskCtrl.stream;
  List<TaskViewCompactModel> get taskList => _taskList;
  List<TaskViewCompactModel> get userTask => _userTask;



  getTask(int prjId) async {
    List<TaskViewCompactModel> entire = await _taskRepository.getTaskList(prjId);
    _taskList = List.from(entire);
    taskSink();
  }

  taskSink(){
    _getTaskOriCtrl.sink.add(_taskList);
  }

  getUserTask(int userId, int prjId) async{
    List<TaskViewCompactModel> entire = await _taskRepository.getUserTaskList(userId, prjId);
    _userTask = List.from(entire);
    userTaskSink();
  }

  userTaskSink(){
    _getMyTaskListCtrl.sink.add(_userTask);
  }

  getCptTask(int userId) async {
    List<TaskAssignedCompactView> entire = await _taskRepository.getUserTaskAll(userId);
    _getPrjUserTaskCtrl.sink.add(entire);
  }

  getPrjCptTask(int userId, int prjId) async {
    List<TaskAssignedCompactView> entire = await _taskRepository.getProjectUserTask(userId, prjId);
    _getPrjUserTaskCtrl.sink.add(entire);
  }
}
