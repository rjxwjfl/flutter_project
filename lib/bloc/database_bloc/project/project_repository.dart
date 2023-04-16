import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/project/project_member_model.dart';
import '../model/project/project_model.dart';
import '../model/project/project_overview_model.dart';
import '../model/project/project_rule_model.dart';
import '../model/user/user_dtl_model.dart';

class ProjectRepository {
  final String baseUrl = "http://10.0.2.2:8080";

  Future<List<ProjectOverViewModel>> getProjectList(int? pg, String? sk, int? st) async {
    String url;
    if (pg == null){
      url = '$baseUrl/project?pg=1';
    } else {
      url = '$baseUrl/project?pg=$pg';
    }
    if (sk != null) {
      url += '&sk=$sk';
    }
    if (st != null) {
      url += '&st=$st';
    }

    final response = await http.get(Uri.parse(url)).timeout(const Duration(milliseconds: 5000));
    print(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<ProjectOverViewModel> projectList = data.map((json) => ProjectOverViewModel.fromMap(json)).toList();
      return projectList;
    } else {
      throw Exception('Failed to fetch projects');
    }
  }

  Future<List<ProjectOverViewModel>> getMyProjectList(int? userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/project?pid=$userId')).timeout(const Duration(milliseconds: 5000));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<ProjectOverViewModel> projectList = data.map((json) => ProjectOverViewModel.fromMap(json)).toList();
      return projectList;
    } else {
      throw Exception('Failed to fetch projects');
    }
  }

  Future<ProjectModel> getProject(int projectId) async {
    final response = await http.get(Uri.parse("$baseUrl/project/dtl?pid=$projectId"));
    if (response.statusCode == 200){
      List<dynamic> data = jsonDecode(response.body);
      Map<String, dynamic> projectMap = data[0]; // get the first project object as a map
      ProjectModel model = ProjectModel.fromMap(projectMap);
      return model;
    } else {
      throw Exception('Failed to fetch projects');
    }
  }

  Future<ProjectRuleModel> getProjectRule(int projectId) async {
    final response = await http.get(Uri.parse('http://localhost:8080/project/rule?pid=$projectId'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)[0];
      return ProjectRuleModel.fromMap(json);
    } else {
      throw Exception('Failed to load project');
    }
  }

  Future<ProjectMemberModel> getProjectMember(int projectId) async {
    final response = await http.get(Uri.parse('http://localhost:8080/project/member?pid=$projectId'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)[0];
      return ProjectMemberModel.fromMap(json);
    } else {
      throw Exception('Failed to load project');
    }
  }

  Future<UserDtlModel> getUser(int userId) async{
    final response = await http.get(Uri.parse("$baseUrl/user/info?uid=$userId"));
    if (response.statusCode == 200){
      List<dynamic> data = jsonDecode(response.body);
      Map<String, dynamic> userData = data[0];
      UserDtlModel model = UserDtlModel.fromMap(userData);
      return model;
    } else {
      throw Exception('Failed to fetch projects');
    }
  }
}
