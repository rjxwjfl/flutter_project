import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_overview_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_bloc.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_repository.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_dowith/view/dowith/main_screen/model/overview_ui.dart';
import 'package:flutter_dowith/view/dowith/project/project_navi_frame.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoWithMainScreen extends StatefulWidget {
  const DoWithMainScreen({Key? key}) : super(key: key);

  @override
  State<DoWithMainScreen> createState() => _DoWithMainScreenState();
}

class _DoWithMainScreenState extends State<DoWithMainScreen>{
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
      child: Consumer(builder: (context, ref, child) {
        var refs = ref.watch(user);
        return StreamBuilder<List<ProjectOverViewModel>>(
          stream: _bloc.myOverViewController,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("프로젝트가 존재하지 않습니다."),
              );
            }
            List<ProjectOverViewModel> data = snapshot.data!;
            return RefreshIndicator(
              onRefresh: () => _bloc.getMyOverView(_key),
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return OverViewUI(
                      data: data[index],
                      callback: () async {
                        refs.fetchUserRole(data[index].prjId).then((value) {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ProjectNaviFrame(
                                prjId: data[index].prjId,
                              ),
                            ),
                          );
                        });
                      },
                    );
                  }),
            );
          },
        );
      }),
    );
  }
}
