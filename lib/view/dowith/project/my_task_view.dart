import 'package:flutter/material.dart';
import 'package:flutter_dowith/view/dowith/project/task/model/task_dtl_view_compact.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyTaskView extends StatelessWidget {
  const MyTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return TaskDtlViewCompact(index: index);
        },
      ),
    );
  }
}
