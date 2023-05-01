import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/members_list_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_bloc.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_repository.dart';
import 'package:flutter_dowith/utils/convert_data.dart';

class EntryViewUI extends StatefulWidget {
  const EntryViewUI({Key? key}) : super(key: key);

  @override
  State<EntryViewUI> createState() => _EntryViewUIState();
}

class _EntryViewUIState extends State<EntryViewUI> {
  final ProjectBloc _bloc = ProjectBloc(ProjectRepository());

  @override
  void initState() {
    super.initState();
    _bloc.getMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.only(left: 20, right: 20),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "프로젝트 참가자",
              style: TextStyle(fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: StreamBuilder<List<MembersListModel>>(
                  stream: _bloc.mbrListController,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<MembersListModel> data = snapshot.data!;
                    return ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 200, maxHeight: 300),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return getMemberView(context, data[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget getMemberView(context, MembersListModel model) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: model.imageUrl == null || model.imageUrl == ""
                  ? Text(
                      model.name[0].toUpperCase(),
                      style: TextStyle(fontSize: 25, color: Theme.of(context).colorScheme.onSecondary),
                    )
                  : null,
            ),
            Expanded(child: Center(child: Text(model.name))),
            Column(
              children: [
                Text(intToString(model.role)),
                RichText(text: TextSpan(children: [TextSpan(text: "최종 접속일\n"), TextSpan(text: timePast(model.latestAccess))]))
              ],
            )
          ],
        ),
      ),
    );
  }
}