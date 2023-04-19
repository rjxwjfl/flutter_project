import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_get_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_member_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_bloc.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_repository.dart';
import 'package:flutter_dowith/bloc/database_bloc/userCtrl/user_bloc.dart';
import 'package:flutter_dowith/bloc/database_bloc/userCtrl/user_repository.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_dowith/view/dowith/project/model/entry_view_ui.dart';
import 'package:flutter_dowith/view/dowith/project/model/project_dtl_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectMain extends StatefulWidget {
  const ProjectMain({required this.prjId, Key? key}) : super(key: key);

  final int prjId;

  @override
  State<ProjectMain> createState() => _ProjectMainState();
}

class _ProjectMainState extends State<ProjectMain> {
  final ProjectBloc _projectBloc = ProjectBloc(ProjectRepository());
  bool _isClicked = false;
  int? userId = prefs.getInt("user_id");
  int? userRole;

  void blocInit() {
    _projectBloc.getCurrentProject(widget.prjId);
    _projectBloc.getPrjRules();
  }

  @override
  void initState() {
    super.initState();
    blocInit();
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
        ProjectGetModel prjModel = snapshot.data!;
        return Consumer(builder: (context, ref, child) {
          var userRefs = ref.watch(user);
          userRefs.fetchUserRole(widget.prjId);
          return Scaffold(
            appBar: AppBar(
              title: Text(prjModel.title),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) {
                          return const EntryViewUI();
                        }),
                    icon: FaIcon(
                      FontAwesomeIcons.users,
                      color: scheme.primary,
                      size: 20,
                    ),
                  ),
                ),
                userRefs.userRole == 0
                    ? Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.gears,
                            color: scheme.primary,
                            size: 20,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            body: RefreshIndicator(
                onRefresh: () async {
                  blocInit();
                },
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                        delegate: SliverChildListDelegate([
                      ProjectDtlUI(
                        data: prjModel,
                        clickState: _isClicked,
                        stream: _projectBloc.ruleController,
                        callback: () {
                          setState(() {
                            _isClicked = !_isClicked;
                          });
                        },
                      ),
                      getTitleUI("SCHEDULE"),
                      const Placeholder(
                        child: SizedBox(
                            height: 100,
                            child: Center(child: Text("Calendar?"))),
                      ),
                      getTitleUI("MY TASK"),
                      const Placeholder(
                        child: SizedBox(
                            height: 150, child: Center(child: Text("TASKS?"))),
                      ),
                      getTitleUI("FEED"),
                      const Placeholder(
                        child: SizedBox(
                            height: 300, child: Center(child: Text("TASKS?"))),
                      ),
                      getTitleUI("INBOX"),
                      const Placeholder(
                        child: SizedBox(
                            height: 100,
                            child: Center(child: Text("FILES - GRID?"))),
                      ),
                    ]))
                  ],
                )),
            floatingActionButton: FloatingActionButton(onPressed: () {}),
          );
        });
      },
    );
  }

  Widget getTitleUI(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: SizedBox(
        child: Row(
          children: [
            Expanded(child: Text(title, textAlign: TextAlign.start)),
            const Text("SHOW MORE >>")
          ],
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
