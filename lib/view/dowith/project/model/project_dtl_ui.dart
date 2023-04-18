import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_get_model.dart';

class ProjectDtlUI extends StatelessWidget {
  const ProjectDtlUI({required this.data, Key? key}) : super(key: key);

  final ProjectGetModel data;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(data.prjDesc),
              Text(data.goal),
              TextButton(onPressed: (){}, child: const Text("규칙 확인"))
            ],
          ),
        ),
      ),
    );
  }
}
