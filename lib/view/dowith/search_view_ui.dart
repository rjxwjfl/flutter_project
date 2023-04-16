import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_overview_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/project/project_bloc.dart';
import 'package:flutter_dowith/bloc/database_bloc/project/project_repository.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_dowith/view/dowith/model/overview_ui.dart';
import 'package:flutter_dowith/view/dowith/project/model/search_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchViewUI extends StatefulWidget {
  const SearchViewUI({Key? key}) : super(key: key);

  @override
  State<SearchViewUI> createState() => _SearchViewUIState();
}

class _SearchViewUIState extends State<SearchViewUI> {
  int? page;
  String? searchKeyword;
  List<int>? filters;
  int? sort;
  final ProjectBloc _bloc = ProjectBloc(ProjectRepository());
  final ProjectRepository repository = ProjectRepository();
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;

  Future<void> saveKeyword(String keyword) async{
    List<String> keywords = prefs.getStringList('keywords') ?? [];
    keywords.add(keyword);
    if (keywords.length > 10){
      keywords.removeAt(0);
    }
    await prefs.setStringList('keywords', keywords);
  }

  @override
  void initState() {
    super.initState();
    _bloc.getOverView(page, searchKeyword, filters, sort); // Frequent rebuilds should be avoided.
    _textEditingController = TextEditingController();
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
        child: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              leadingWidth: 30.0,
              title: SearchBarUI(
                controller: _textEditingController,
                hintText: "검색할 프로젝트를 입력하세요.",
                focusNode: _focusNode,
                color: ref.watch(themeProv).setMaterialColor(context),
                callback: (value){
                  if (value != null && value.isNotEmpty){
                    saveKeyword(value);
                    setState(() {
                      searchKeyword = _textEditingController.text;
                    });
                    _bloc.getOverView(page, searchKeyword, filters, sort);
                  }
                  print(value);
                  FocusScope.of(context).unfocus();
                },
                removeCallback: (){
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
                    color: ref.watch(themeProv).setMaterialColor(context),
                    child: StreamBuilder<List<ProjectOverViewModel>>(
                      stream: _bloc.overViewController,
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
                              onRefresh: () => _bloc.getOverView(null, searchKeyword, filters, sort),
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
                  ),
                ),
              ],
            ),
          );
        }),
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
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10),
                      Text(
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
                      Text(
                        'Filter',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Padding(
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
