import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_get_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_bloc.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_repository.dart';
import 'package:flutter_dowith/view/dowith/project/model/project_dtl_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectMain extends StatefulWidget {
  const ProjectMain({required this.prjId, Key? key}) : super(key: key);

  final int prjId;

  @override
  State<ProjectMain> createState() => _ProjectMainState();
}

class _ProjectMainState extends State<ProjectMain> {
  final ProjectBloc _projectBloc = ProjectBloc(ProjectRepository());

  @override
  void initState() {
    super.initState();
    _projectBloc.getCurrentProject(widget.prjId);
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return StreamBuilder<ProjectGetModel>(
      stream: _projectBloc.projectController,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        ProjectGetModel data = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            title: Text(data.title),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.users,
                    color: scheme.primary,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          body: RefreshIndicator(
              onRefresh: () async {
                _projectBloc.getCurrentProject(widget.prjId);
              },
              child: CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    ProjectDtlUI(data: data),
                    getTitleUI("SCHEDULE"),
                    const Placeholder(
                      child: SizedBox(height: 100, child: Center(child: Text("Calendar?"))),
                    ),
                    getTitleUI("MY TASK"),
                    const Placeholder(
                      child: SizedBox(height: 150, child: Center(child: Text("TASKS?"))),
                    ),
                    getTitleUI("FEED"),
                    const Placeholder(
                      child: SizedBox(height: 300, child: Center(child: Text("TASKS?"))),
                    ),
                    getTitleUI("INBOX"),
                    const Placeholder(
                      child: SizedBox(height: 100, child: Center(child: Text("FILES - GRID?"))),
                    ),
                  ]))
                ],
              )),
          floatingActionButton: FloatingActionButton(onPressed: () {}),
        );
      },
    );
  }

  Widget getTitleUI(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: SizedBox(
        child: Row(
          children: [Expanded(child: Text(title, textAlign: TextAlign.start)), const Text("SHOW MORE >>")],
        ),
      ),
    );
  }

  Widget getContribution() {
    return SingleChildScrollView(
      child: SizedBox(
        height: 110,
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.all(5),
                  child: Placeholder(
                    fallbackWidth: 100,
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget getMyTaskOverView(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: ((context, index) {
            return const Padding(
              padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Placeholder(
                fallbackHeight: 100,
              ),
            );
          })),
    );
  }
}
