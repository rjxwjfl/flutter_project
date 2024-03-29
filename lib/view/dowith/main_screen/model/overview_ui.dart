import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_overview_model.dart';
import 'package:flutter_dowith/view/dowith/main_screen/model/project_status_sum.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class OverViewUI extends StatelessWidget {
  const OverViewUI({required this.data, required this.callback, Key? key}) : super(key: key);

  final ProjectOverViewModel data;
  final void Function() callback;

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 0.5, color: scheme.primary),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          onTap: callback,
          child: Ink(
            width: MediaQuery.of(context).size.width,
            height: 170,
            color: scheme.surface,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Row(
                children: [
                  Container(
                    color: Theme.of(context).colorScheme.primary,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getCategoryTransfer(data.category, context),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: getSummaryView(),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text("Title : ${data.title}")),
                                  CircleAvatar(
                                    // backgroundImage: NetworkImage("${data.masterImageUrl}"),
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    child: data.masterImageUrl == null || data.masterImageUrl == ""
                                        ? Text(data.masterName[0].toUpperCase())
                                        : null,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                child: Divider(color: scheme.onSurface, height: 1),
                              ),
                              Text("${data.masterImageUrl}"),
                              const SizedBox(height: 10),
                              Text("Detail : ${data.prjDesc}"),
                              const SizedBox(height: 7),
                              Text("Goal : ${data.goal}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getCategoryTransfer(int category, context) {
    IconData categoryIcon;
    String categoryTitle;
    switch (category) {
      case 1:
        categoryIcon = FontAwesomeIcons.users;
        categoryTitle = "TEAM-WORK";
        break;
      case 2:
        categoryIcon = FontAwesomeIcons.pencil;
        categoryTitle = "STUDY";
        break;
      case 3:
        categoryIcon = FontAwesomeIcons.dumbbell;
        categoryTitle = "EXERCISE";
        break;
      case 4:
        categoryIcon = FontAwesomeIcons.icons;
        categoryTitle = "HOBBIES";
        break;
      case 5:
        categoryIcon = FontAwesomeIcons.code;
        categoryTitle = "DEVELOP";
        break;
      default:
        categoryIcon = FontAwesomeIcons.question;
        categoryTitle = "UNKNOWN";
        break;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FaIcon(categoryIcon, size: 40, color: Theme.of(context).colorScheme.surface),
        Text(
          categoryTitle,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.surface),
        ),
      ],
    );
  }

  Widget getSummaryView() {
    DateFormat formatter = DateFormat("yy MM.dd");
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjectStatusSum(
                padding: const EdgeInsets.only(top: 10),
                icon: FontAwesomeIcons.usersLine,
                iconSize: 15,
                text: "${data.memberCount}명",
                fontSize: 12),
            data.startOn != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Column(
                      children: [
                        ProjectStatusSum(
                            padding: const EdgeInsets.only(top: 5),
                            icon: FontAwesomeIcons.hourglassStart,
                            iconSize: 12.0,
                            text: formatter.format(data.startOn!),
                            fontSize: 11.0),
                        ProjectStatusSum(
                            padding: const EdgeInsets.only(top: 5),
                            icon: FontAwesomeIcons.hourglassEnd,
                            iconSize: 12.0,
                            text: formatter.format(data.expireOn!),
                            fontSize: 11.0),
                      ],
                    ),
                  )
                : const ProjectStatusSum(
                    padding: EdgeInsets.only(top: 5, left: 4),
                    icon: FontAwesomeIcons.hourglass,
                    iconSize: 12,
                    text: "제한 없음",
                    fontSize: 10),
          ],
        ),
      ),
    );
  }
}
// data.startOn != null
// ? Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(5),
// border: Border.all(color: Theme.of(context).colorScheme.onSurface),
// ),
// child: const Padding(
// padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
// child: Text(
// "23.04.01 ~ 23.04.25",
// style: TextStyle(fontSize: 10),
// ),
// ),
// )
//     : const SizedBox(),
