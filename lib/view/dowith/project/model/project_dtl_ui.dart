import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_get_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_rule_model.dart';

class ProjectDtlUI extends StatelessWidget {
  const ProjectDtlUI(
      {required this.data,
      required this.clickState,
      required this.callback,
      required this.stream,
      Key? key})
      : super(key: key);

  final ProjectGetModel data;
  final bool clickState;
  final void Function() callback;
  final Stream<List<ProjectRuleModel>> stream;

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
              clickState
                  ? StreamBuilder<List<ProjectRuleModel>>(
                      stream: stream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("프로젝트 규칙이 존재하지 않습니다."),
                              TextButton(onPressed: callback, child: const Text("규칙 추가")),
                            ],
                          );
                        }
                        List<ProjectRuleModel> data = snapshot.data!;
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return getRuleView(data[index]);
                            });
                      },
                    )
                  : TextButton(
                      onPressed: callback,
                      child: const Text("규칙 확인"),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRuleView(ProjectRuleModel data) {
    return Container();
  }
}
