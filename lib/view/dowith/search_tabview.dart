import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/server_bloc/model/project/project_overview_model.dart';
import 'package:flutter_dowith/bloc/server_bloc/project_bloc.dart';
import 'package:flutter_dowith/bloc/server_bloc/project_repository.dart';
import 'package:flutter_dowith/view/dowith/model/overview_ui.dart';
import 'package:flutter_dowith/view/dowith/project/model/search_model.dart';

class SearchTabView extends StatefulWidget {
  const SearchTabView({required this.textEditingController, required this.focusNode, required this.materialColor, Key? key})
      : super(key: key);

  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final Color materialColor;

  @override
  State<SearchTabView> createState() => _SearchTabViewState();
}

class _SearchTabViewState extends State<SearchTabView> {
  int? page;
  String? searchKeyword;
  List<int>? categories;
  String? sort;
  final ProjectBloc _bloc = ProjectBloc(ProjectRepository());
  final ProjectRepository repository = ProjectRepository();

  @override
  void initState() {
    super.initState();
    _bloc.getOverView(page, searchKeyword, categories, sort);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SearchBarUI(controller: widget.textEditingController, hintText: "SEARCHING FOR", focusNode: widget.focusNode),
        ),
        getFilterBarUI(),
        Expanded(
          child: Material(
            color: widget.materialColor,
            child: StreamBuilder<List<ProjectOverViewModel>>(
              stream: _bloc.overViewController,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.data!.isEmpty){
                    return const Center(
                      child: Text("프로젝트가 존재하지 않습니다."),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                        itemBuilder: (context, index){
                      return OverViewUI(data: snapshot.data![index]);
                    });
                  }
                }
              },
            ),
          ),
        ),
      ],
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
                  padding: EdgeInsets.only(left: 8),
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
