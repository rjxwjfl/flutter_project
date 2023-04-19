import 'dart:convert';

import 'package:flutter_dowith/bloc/database_bloc/model/project/project_member_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/user/user_dtl_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/user/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final String baseUrl = "http://10.0.2.2:8080";

  Future<UserModel?> getUserData() async {
    return null;
  }

  Future<UserDtlModel> getUserDtl(int userId) async {
    final response =
        await http.get(Uri.parse("$baseUrl/user/info?uid=$userId"));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      Map<String, dynamic> userData = data[0];
      UserDtlModel model = UserDtlModel.fromMap(userData);
      return model;
    } else {
      throw Exception('Failed to fetch projects');
    }
  }

  Future<ProjectMemberModel> getUserRole(int prjId, int userId) async {
    final response =
        await http.get(Uri.parse("$baseUrl/user?pid=$prjId&uid=$userId"));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch roles');
    }
    List<dynamic> data = jsonDecode(response.body);
    Map<String, dynamic> map = data[0];
    ProjectMemberModel model = ProjectMemberModel.fromMap(map);
    return model;
  }
}
