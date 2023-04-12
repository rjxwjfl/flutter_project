import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/project/project_overview_model.dart';
import 'package:flutter_dowith/bloc/test_code.dart';
import 'package:flutter_dowith/view/dowith/model/project_status_sum.dart';
import 'package:flutter_dowith/view/dowith/project/project_home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class OverViewUI extends StatelessWidget {
  const OverViewUI({required this.data, Key? key}) : super(key: key);

  final ProjectOverViewModel data;

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
      child: Card(
        elevation: 10.0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          onTap: () {
            TestCode().getProject(data.prjId).then((value) {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => ProjectHome(data: value),
                  ));
            });
          },
          child: Ink(
            width: MediaQuery.of(context).size.width,
            height: 160,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Row(
                children: [
                  Container(
                    color: Theme.of(context).colorScheme.primary,
                    width: 100,
                    height: MediaQuery.of(context).size.height,
                    child: getCategoryTransfer(data.category, context),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Title : ${data.title}"),
                              Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                child: Divider(color: scheme.onSurface, height: 1),
                              ),
                              Text("Author : ${data.masterName}"),
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
    DateFormat formatter = DateFormat("yy MM.dd");
    IconData categoryIcon;
    String categoryTitle;
    switch (category) {
      case 1:
        categoryIcon = FontAwesomeIcons.users;
        categoryTitle = "CO-WORK";
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
        categoryTitle = "DEVELOPMENT";
        break;
      default:
        categoryIcon = FontAwesomeIcons.question;
        categoryTitle = "UNKNOWN";
        break;
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(categoryIcon, size: 40, color: Theme.of(context).colorScheme.surface),
          const SizedBox(height: 10),
          Text(
            categoryTitle,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.surface),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: SizedBox(
              child: Column(
                children: [
                  ProjectStatusSum(
                      padding: const EdgeInsets.only(top: 10),
                      icon: FontAwesomeIcons.usersLine,
                      iconSize: 15,
                      text: "${data.memberCount}명",
                      fontSize: 12),
                  data.startOn != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Column(
                            children: [
                              ProjectStatusSum(
                                  padding: const EdgeInsets.only(top: 5),
                                  icon: FontAwesomeIcons.hourglassStart,
                                  iconSize: 15.0,
                                  text: formatter.format(data.startOn!),
                                  fontSize: 10.0),
                              ProjectStatusSum(
                                  padding: const EdgeInsets.only(top: 5),
                                  icon: FontAwesomeIcons.hourglassEnd,
                                  iconSize: 15.0,
                                  text: formatter.format(data.expireOn!),
                                  fontSize: 10.0),
                            ],
                          ),
                        )
                      : const ProjectStatusSum(
                          padding: EdgeInsets.only(top: 5, left: 4),
                          icon: FontAwesomeIcons.hourglass,
                          iconSize: 15,
                          text: "제한 없음",
                          fontSize: 10),
                ],
              ),
            ),
          ),
        ],
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
