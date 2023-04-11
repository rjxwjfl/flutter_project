import 'package:flutter_dowith/bloc/server_bloc/model/project/project_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class TestCode{
  String baseUrl = "http://10.0.2.2:8080";

  Future<ProjectModel> getProject(int id) async{
    final response = await http.get(Uri.parse("$baseUrl/project/dtl?pid=$id"));
    if (response.statusCode == 200){
      print(response.body);
      List<dynamic> data = jsonDecode(response.body);
      Map<String, dynamic> projectMap = data[0]; // get the first project object as a map
      ProjectModel model = ProjectModel.fromMap(projectMap);
      return model;
    } else {
      throw Exception('Failed to fetch projects');
    }
  }
}