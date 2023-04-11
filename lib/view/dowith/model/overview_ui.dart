import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/server_bloc/model/project/project_overview_model.dart';
import 'package:flutter_dowith/bloc/test_code.dart';
import 'package:flutter_dowith/view/dowith/project/project_home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OverViewUI extends StatelessWidget {
  const OverViewUI({required this.data, Key? key}) : super(key: key);

  final ProjectOverViewModel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 3, 12, 3),
      child: Card(
        elevation: 10.0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          onTap: () {
            TestCode().getProject(data.prjId).then(
              (value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjectHome(data: value),
                  ),
                );
              },
            );
          },
          child: Ink(
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Row(
                children: [
                  Container(
                    color: Theme.of(context).colorScheme.primary,
                    width: 80,
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
                              Text("Author : ${data.masterName}"),
                              const SizedBox(height: 10),
                              Text("Detail : ${data.prjDesc}"),
                              const SizedBox(height: 7),
                              Text("Goal : ${data.goal}"),
                            ],
                          ),
                          data.startOn != null
                              ? Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Theme.of(context).colorScheme.onSurface),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                                      child: Text(
                                        "23.04.01 ~ 23.04.25",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.supervisor_account_rounded,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "${data.memberCount}",
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          )
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
        const SizedBox(height: 10),
        Text(
          categoryTitle,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.surface),
        ),
      ],
    );
  }
}
