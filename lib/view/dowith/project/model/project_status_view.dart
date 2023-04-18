import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_set_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/user/user_dtl_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_bloc.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_repository.dart';
import 'package:flutter_dowith/view/dowith/project/model/item_desc_view.dart';


class ProjectStatusView extends StatefulWidget {
  const ProjectStatusView({required this.prjData, required this.color, Key? key}) : super(key: key);

  final ProjectSetModel prjData;
  final Color color;

  @override
  State<ProjectStatusView> createState() => _ProjectStatusViewState();
}

class _ProjectStatusViewState extends State<ProjectStatusView> {
  ProjectBloc userDtlBloc = ProjectBloc(ProjectRepository());

  @override
  void initState() {
    super.initState();
    userDtlBloc.getUserDtlInfo(widget.prjData.mstId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, kToolbarHeight + 20, 12, 12),
      child: Container(
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(5)), color: widget.color),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder(
                      stream: userDtlBloc.userDtlController,
                      builder: (context, AsyncSnapshot<UserDtlModel> snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data!;
                          return GestureDetector(
                            onTap: (){
                              print("Model : $data");
                            },
                            child: CircleAvatar(
                              backgroundImage: data.imageUrl != null ? NetworkImage("${data.imageUrl}") : null,
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              child: data.imageUrl == null ? Text(data.name[0].toUpperCase()) : null,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      }),
                  ItemDescView(title: "설명", content: widget.prjData.prjDesc),
                  ItemDescView(title: "목표", content: widget.prjData.goal)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("PROGRESS"),
                  Placeholder(
                    fallbackHeight: 100,
                    fallbackWidth: 100,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
