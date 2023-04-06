import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dowith/bloc/server_bloc/model/project_model.dart';

class ProjectRepository {
  Future<List<ProjectOverViewModel>> getProjectList(int? page, String? searchKeyword, List<int>? categories, String? sort) async {
    String baseUrl = 'http://10.0.2.2:8080/project';
    if (searchKeyword != null) {
      baseUrl += '&searchKeyword=$searchKeyword';
    }
    if (categories != null) {
      baseUrl += '&category=${categories.join(',')}';
    }
    if (sort != null) {
      baseUrl += '&sort=$sort';
    }
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<ProjectOverViewModel> projectList = data.map((json) => ProjectOverViewModel.fromMap(json)).toList();
      return projectList;
    } else {
      throw Exception('Failed to fetch projects');
    }
  }

  Future<List<ProjectOverViewModel>> getMyProjectList(int userId) async {
    final response = await http.get(Uri.parse('http://localhost:8080/user/project?pid=$userId'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ProjectOverViewModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch projects');
    }
  }

  Future<ProjectModel> getProject(int projectId) async {
    final response = await http.get(Uri.parse('http://localhost:8080/project/dtl?pid=$projectId'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)[0];
      return ProjectModel.fromMap(json);
    } else {
      throw Exception('Failed to load project');
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
}
