import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_model.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_dowith/view/dowith/project/model/project_status_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectOverView extends StatefulWidget {
  const ProjectOverView({required this.data, Key? key}) : super(key: key);

  final ProjectModel data;

  @override
  State<ProjectOverView> createState() => _ProjectOverViewState();
}

class _ProjectOverViewState extends State<ProjectOverView> {
  late ScrollController _scrollController;
  bool lastStatus = true;
  double height = 250;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() => _scrollListener());
  }

  @override
  void dispose() {
    _scrollController.removeListener(() => _scrollListener());
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  Color setBackGroundColor() {
    if (Theme.of(context).brightness == Brightness.light) {
      return Color(0xFFEDF0F2);
    } else {
      return Color(0xFF383838);
    }
  }

  bool get _isShrink {
    return _scrollController.hasClients && _scrollController.offset > (height - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Scaffold(
            backgroundColor: ref.watch(themeProv).setMaterialColor(context),
            body: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    elevation: 0,
                    pinned: true,
                    floating: true,
                    snap: true,
                    collapsedHeight: kToolbarHeight,
                    expandedHeight: 270,
                    title: Text(widget.data.title),
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: ProjectStatusView(prjData: widget.data, color: setBackGroundColor()),
                    ),
                  ),
                ];
              },
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 150,
                    ),
                  )
                ],
              ),
            ));
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
