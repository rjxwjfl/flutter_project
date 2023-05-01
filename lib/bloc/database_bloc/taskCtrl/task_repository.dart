import 'dart:convert';
import 'package:flutter_dowith/bloc/database_bloc/model/task/task_assigned_view.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/task/task_view_compact_model.dart';
import 'package:http/http.dart' as http;

class TaskRepository {
  final String baseUrl = "http://10.0.2.2:8080/task";

  Future<List<TaskViewCompactModel>> getTaskList(int prjId) async{
    String url = "$baseUrl/taskList?pid=$prjId";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200){
      throw Exception(response.body);
    }
    final List<dynamic> data = jsonDecode(response.body);
    final List<TaskViewCompactModel> taskList = data.map((json) => TaskViewCompactModel.fromJson(json)).toList();
    return taskList;
  }

  Future<List<TaskViewCompactModel>> getUserTaskList(int userId, int? prjId) async{
    String url = "$baseUrl/userTaskList?uid=$userId";
    if (prjId != null){
      url += "&pid=$prjId";
    }
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200){
      throw Exception(response.body);
    }
    final List<dynamic> data = jsonDecode(response.body);
    final List<TaskViewCompactModel> taskList = data.map((json) => TaskViewCompactModel.fromJson(json)).toList();
    return taskList;
  }


  Future<List<TaskAssignedCompactView>> getUserTaskAll(int userId) async {
    String url = "$baseUrl/?uid=$userId";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    final List<dynamic> data = jsonDecode(response.body);
    final List<TaskAssignedCompactView> taskViewList =
        data.map((json) => TaskAssignedCompactView.fromJson(json)).toList();
    return taskViewList;
  }

  Future<List<TaskAssignedCompactView>> getProjectUserTask(int userId, int prjId) async{
    String url = "$baseUrl/?uid=$userId&pid=$prjId";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception();
    }
    final List<dynamic> data = jsonDecode(response.body);
    final List<TaskAssignedCompactView> taskViewList =
    data.map((json) => TaskAssignedCompactView.fromJson(json)).toList();
    return taskViewList;
  }

  // Future<TaskAssignedCompactView> taskUpdate(int taId) async{
  //   return ;
  // }
}
