import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_overview_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_bloc.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_repository.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_dowith/view/dowith/model/overview_ui.dart';
import 'package:flutter_dowith/view/dowith/project/project_navi_home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DwMain extends StatefulWidget {
  const DwMain({Key? key}) : super(key: key);

  @override
  State<DwMain> createState() => _DwMainState();
}

class _DwMainState extends State<DwMain> with AutomaticKeepAliveClientMixin {
  final ProjectBloc _bloc = ProjectBloc(ProjectRepository());
  final int? _key = prefs.getInt("user_id");

  @override
  void initState() {
    super.initState();
    _bloc.getMyOverView(_key);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ProjectNaviHome(
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

  @override
  bool get wantKeepAlive => true;
}
