import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_overview_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_bloc.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_repository.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_dowith/view/dowith/model/overview_ui.dart';

class DwMain extends StatefulWidget {
  const DwMain({Key? key}) : super(key: key);

  @override
  State<DwMain> createState() => _DwMainState();
}

class _DwMainState extends State<DwMain> {
  final ProjectBloc _bloc = ProjectBloc(ProjectRepository());
  final int? _key = prefs.getInt("user_id");

  @override
  void initState() {
    super.initState();
    _bloc.getMyOverView(_key);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder<List<ProjectOverViewModel>>(
        stream: _bloc.myOverViewController,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("프로젝트가 존재하지 않습니다."),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () => _bloc.getMyOverView(_key),
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return OverViewUI(data: snapshot.data![index]);
                    }),
              );
            }
          }
        },
      ),
    );
  }
}
