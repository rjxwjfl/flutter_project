import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskDtlViewCompact extends StatefulWidget {
  const TaskDtlViewCompact({required this.index, Key? key}) : super(key: key);

  final int index;

  @override
  State<TaskDtlViewCompact> createState() => _TaskDtlViewCompactState();
}

class _TaskDtlViewCompactState extends State<TaskDtlViewCompact> {
  bool _isFold = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              onTap: () {
                setState(() {
                  _isFold = !_isFold;
                });
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Category>",
                              style: TextStyle(fontSize: 10),
                            ),
                            Text("수정 ${widget.index}번 파트"),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text("6시간 남음", style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
                          Text("~16:35", style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                  const Divider()
                ],
              ),
            ),
          ),
          AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: _isFold ? MediaQuery.of(context).size.width * 0.15 : 0.0,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedOpacity(
                      opacity: _isFold ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 100),
                      child: const Icon(
                        FontAwesomeIcons.check,
                        color: Colors.green,
                      )),
                ),
              )),
        ],
      ),
    );
  }
}
