import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/dowith/project/project_home.dart';

class ListOverView extends StatelessWidget {
  const ListOverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Card(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
              opaque: false, // 배경 투명화 여부
              pageBuilder: (BuildContext context, _, __) {
                return const ProjectHome(); // 새로운 페이지
              },
              transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                return FadeTransition(
                  opacity: animation,
                  child: child, // 새로운 페이지 애니메이션
                );
              },
            ),);
          },
          child: Ink(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Row(
                children: [
                  Container(
                    color: Theme.of(context).colorScheme.primary,
                    width: 50,
                    height: MediaQuery.of(context).size.height,
                  ),
                  const Expanded(child: Center(child: Text("Content"))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
