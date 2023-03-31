import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/dowith/model/inbox_model.dart';

class ProjectInbox extends StatelessWidget {
  const ProjectInbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
            itemBuilder: (context, index){
          return const InboxModel();
        }),
      ],
    );
  }
}
