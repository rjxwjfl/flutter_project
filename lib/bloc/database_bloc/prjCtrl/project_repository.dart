import 'dart:convert';
import 'package:flutter_dowith/bloc/database_bloc/model/project/members_list_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_get_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_set_model.dart';
import 'package:http/http.dart' as http;

import '../model/project/project_overview_model.dart';
import '../model/project/project_rule_model.dart';

class ProjectRepository {
  final String baseUrl = "http://10.0.2.2:8080";

  Future<List<ProjectOverViewModel>> getProjectList(int pg, String? sk, int? st) async {
    String url = '$baseUrl/project?pg=$pg';
    if (sk != null) {
      url += '&sk=$sk';
    }
    if (st != null) {
      url += '&st=$st';
    }
    final response = await http.get(Uri.parse(url)).timeout(const Duration(milliseconds: 5000));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<ProjectOverViewModel> projectList = data.map((json) => ProjectOverViewModel.fromJson(json)).toList();
      return projectList;
    } else {
      throw Exception('Failed to fetch projects');
    }
  }

  Future<List<ProjectOverViewModel>> getMyProjectList(int? userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/project?uid=$userId')).timeout(const Duration(milliseconds: 5000));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<ProjectOverViewModel> projectList = data.map((json) => ProjectOverViewModel.fromJson(json)).toList();
      return projectList;
    } else {
      throw Exception('Failed to fetch projects');
    }
  }

  Future<ProjectGetModel> getProject(int projectId) async {
    final response = await http.get(Uri.parse("$baseUrl/project/dtl?pid=$projectId"));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      Map<String, dynamic> projectMap = data[0]; // get the first project object as a map
      ProjectGetModel model = ProjectGetModel.fromJson(projectMap);
      return model;
    } else {
      throw Exception('Failed to fetch projects');
    }
  }

  Future<List<ProjectRuleModel>> getProjectRule(int projectId) async {
    final response = await http.get(Uri.parse('$baseUrl/project/rule?pid=$projectId'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      final List<ProjectRuleModel> rules = data.map((json) => ProjectRuleModel.fromJson(json)).toList();
      return rules;
    } else {
      throw Exception('Failed to load project');
    }
  }

  Future<List<MembersListModel>> getProjectMember(int prjId) async {
    final response = await http.get(Uri.parse('$baseUrl/project/member?pid=$prjId'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<MembersListModel> memberList = data.map((json) => MembersListModel.fromJson(json)).toList();
      return memberList;
    } else {
      throw Exception('Failed to load project');
    }
  }

  Future<int> createProject(int userId, ProjectSetModel model) async {
    String url = '$baseUrl/project?uid=$userId';
    Map<String, dynamic> body = model.toJson();
    final response = await http.post(Uri.parse(url), headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
    if (response.statusCode != 200) {
      throw Exception('Failed to create project');
    }
    Map<String, dynamic> data = jsonDecode(response.body);
    return data['prj_id'];
  }
}
