import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/members_list_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_get_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_bloc.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_repository.dart';
import 'package:flutter_dowith/view/dowith/project/calendar_view.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_dowith/view/dowith/project/model/entry_view_ui.dart';
import 'package:flutter_dowith/view/dowith/project/project_dtl_ui.dart';
import 'package:flutter_dowith/view/dowith/project/model/project_title_ui.dart';
import 'package:flutter_dowith/view/dowith/project/model/user_summary.dart';
import 'package:flutter_dowith/view/dowith/project/my_task_view.dart';
import 'package:flutter_dowith/view/dowith/project/statics_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectMainScreen extends StatefulWidget {
  const ProjectMainScreen({required this.prjId, Key? key}) : super(key: key);

  final int prjId;

  @override
  State<ProjectMainScreen> createState() => _ProjectMainScreenState();
}

class _ProjectMainScreenState extends State<ProjectMainScreen> {
  final ProjectBloc _projectBloc = ProjectBloc(ProjectRepository());
  bool _isClicked = false;
  int? userId = prefs.getInt("user_id");
  int? userRole;

  Future<void> blocInit() async{
    _projectBloc.getCurrentProject(widget.prjId);
    await _projectBloc.getPrjRules();
    await _projectBloc.getMembers();
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
          var themeRefs = ref.watch(theme);
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProjectDtlUI(
                      data: prjModel,
                      clickState: _isClicked,
                      ruleStream: _projectBloc.ruleController,
                      callback: () {
                        setState(() {
                          _isClicked = !_isClicked;
                        });
                      },
                    ),
                    divider(),
                    ProjectTitleUI(title: "일정", subText: "\n새로운 일정을 확인하세요", callback: () {}),
                    const CalendarView(),
                    divider(),
                    ProjectTitleUI(title: "과제",callback: () {}),
                    const MyTaskView(),
                    ProjectTitleUI(title: "통계", callback: () {}),
                    StaticsView(),
                    ProjectTitleUI(title: "피드", subText: "\n프로젝트 피드를 확인하세요", callback: () {}),
                    const Placeholder(
                      child: SizedBox(height: 150, child: Center(child: Text("TASKS?"))),
                    ),
                    ProjectTitleUI(title: "INBOX", subText: "\n프로젝트 관련자료를 확인하세요.", callback: () {}),
                    const Placeholder(
                      child: SizedBox(height: 100, child: Center(child: Text("FILES - GRID?"))),
                    ),
                    ProjectTitleUI(title: "구성원", subText: "", callback: (){}),
                    getMemberOverViewUI(),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Widget divider() {
    return const Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Divider(thickness: 8),
    );
  }

  Widget getMemberOverViewUI() {
    return StreamBuilder<List<MembersListModel>>(
      stream: _projectBloc.mbrListController,
      initialData: null,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<MembersListModel> mbr = snapshot.data!;
        int managerLength = mbr.where((element) => element.role < 2).length;
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: managerLength,
              itemBuilder: (context, index) => UserSummary(
                data: mbr[index],
                callback: () {},
              ),
            ),
          ),
        );
      },
    );
  }
}
