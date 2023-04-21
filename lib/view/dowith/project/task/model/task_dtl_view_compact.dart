import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskDtlViewCompact extends StatelessWidget {
  const TaskDtlViewCompact({required this.index, Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      child: Row(
        children: [
          Text("담당자 : $index"),
          Expanded(child: Center(child: Text("업무 $index"))),
          Icon(FontAwesomeIcons.check, color: Colors.green,),
        ],
      ),
    );
  }
}
