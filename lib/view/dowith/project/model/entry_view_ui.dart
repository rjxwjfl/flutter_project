import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/members_list_model.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_bloc.dart';
import 'package:flutter_dowith/bloc/database_bloc/prjCtrl/project_repository.dart';

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
                RichText(text: TextSpan(children: [TextSpan(text: "최종 접속일\n"), TextSpan(text: dateCal(model.latestAccess))]))
              ],
            )
          ],
        ),
      ),
    );
  }

  String intToString(int role) {
    String result;
    const map = {0: "프로젝트장", 1: "관리자", 2: "구성원", 3: "손님"};
    result = map[role] ?? "손님";
    return result;
  }

  String dateCal(DateTime date) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);
    if (difference.inSeconds < 60) {
      return "${difference.inSeconds}초 전";
    }
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}분 전";
    }
    if (difference.inHours < 24) {
      return "${difference.inHours}시간 전";
    }
    if (difference.inDays < 30) {
      return "${difference.inDays}일 전";
    }
    if (difference.inDays < 365) {
      return "${(difference.inDays / 30).floor()}달 전";
    }
    return "${(difference.inDays / 365).floor()}년 전";
  }
}
// https://bangu4.tistory.com/364
// https://velog.io/@yellowtoast/Flutter-%EC%95%B1-%EB%B0%B0%ED%8F%AC-%ED%9B%84-%ED%8A%B9%EC%A0%95-%EC%95%88%EB%93%9C%EB%A1%9C%EC%9D%B4%EB%93%9C-%ED%8F%B0%EC%97%90%EC%84%9C-%EC%95%B1-%EC%8B%A4%ED%96%89%EC%9D%B4-%EB%90%98%EC%A7%80-%EC%95%8A%EB%8A%94-%ED%98%84%EC%83%81-%ED%95%B4%EA%B2%B0-%EC%A4%91
