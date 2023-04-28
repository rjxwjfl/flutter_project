import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_overview_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_bloc.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_repository.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_dowith/view/dowith/main_screen/model/overview_ui.dart';
import 'package:flutter_dowith/view/dowith/project/model/search_model.dart';
import 'package:flutter_dowith/view/dowith/project/project_navi_frame.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectSearch extends StatefulWidget {
  const ProjectSearch({Key? key}) : super(key: key);

  @override
  State<ProjectSearch> createState() => _ProjectSearchState();
}

class _ProjectSearchState extends State<ProjectSearch> {
  int page = 1;
  String? searchKeyword;
  List<int>? filters;
  int? sort;
  final Bloc _bloc = Bloc(ProjectRepository());
  late TextEditingController _textEditingController;
  late final ScrollController _scrollController;
  late FocusNode _focusNode;

  Future<void> saveKeyword(String keyword) async {
    List<String> keywords = prefs.getStringList('keywords') ?? [];
    keywords.add(keyword);
    if (keywords.length > 10) {
      keywords.removeAt(0);
    }
    await prefs.setStringList('keywords', keywords);
  }

  Future<void> fetchData() async {
    print("fetch start");
    if (_bloc.isLimit){
      print("fetch was forced terminated");
      return;
    }
    _bloc.getOverView(page, searchKeyword, sort);
    setState(() {
      page++;
      print("waiting for loading next page");
    });
  }

  void setSearchKeyword(String keyword) {
    if (searchKeyword != keyword) {
      setState(() {
        page = 1;
        searchKeyword = keyword;
      });
    }
    fetchData();
  }

  void scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      fetchData();
    }
  }

  void blocInit(){
    _bloc.list.clear();
    _bloc.isLimit = false;
  }

  @override
  void initState() {
    super.initState();
    _bloc.list.clear();
    fetchData(); // Frequent rebuilds should be avoided.
    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(scrollListener);
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            var refs = ref.watch(user);
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                leadingWidth: 30.0,
                title: SearchBarUI(
                  controller: _textEditingController,
                  hintText: "검색할 프로젝트를 입력하세요.",
                  focusNode: _focusNode,
                  color: ref.watch(theme).setMaterialColor(context),
                  callback: (value) {
                    if (value != null && value.isNotEmpty) {
                      saveKeyword(value);
                      setSearchKeyword(_textEditingController.text);
                    }
                    FocusScope.of(context).unfocus();
                  },
                  removeCallback: () {
                    _textEditingController.clear();
                    setState(() {
                      searchKeyword = null;
                    });
                  },
                ),
              ),
              body: Column(
                children: [
                  getFilterBarUI(),
                  Expanded(
                    child: Material(
                      color: ref.watch(theme).setMaterialColor(context),
                      child: StreamBuilder<List<ProjectOverViewModel>>(
                        stream: _bloc.overViewController,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          List<ProjectOverViewModel> data = snapshot.data!;
                          if (data.isEmpty) {
                            return const Center(child: Text("프로젝트가 존재하지 않습니다."),);
                          }
                          return RefreshIndicator(
                            onRefresh: () async {
                              setState(() {
                                page = 1;
                              });
                              blocInit();
                              await fetchData();
                            },
                            child: ListView.builder(
                                controller: _scrollController,
                                physics: const BouncingScrollPhysics(),
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return OverViewUI(
                                    data: data[index],
                                    callback: () async {
                                      refs.fetchUserRole(data[index].prjId).then((value) {
                                        if (value > 2 && data[index].pvt) {
                                          showModalBottomSheet<void>(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SizedBox(
                                                height: 200,
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      const Text('비공개 프로젝트입니다.'),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          ElevatedButton(
                                                            child: const Text('가입 신청'),
                                                            onPressed: () => Navigator.pop(context),
                                                          ),
                                                          const SizedBox(width: 20),
                                                          ElevatedButton(
                                                            child: const Text('닫기'),
                                                            onPressed: () => Navigator.pop(context),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                        Navigator.pop(context);
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
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getFilterBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 4),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Category',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'ALL',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.grey.withOpacity(0.2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(4.0),
                ),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: <Widget>[
                      const Text(
                        'Filter',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.sort),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
