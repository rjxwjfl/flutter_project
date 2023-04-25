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
                          Text("6시간 남음",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground)),
                          Text("~16:35",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                  const Divider()
                ],
              ),
            ),
          ),
          _isFold
              ? Row(
                  children: [
                    buttonUI(
                        const Icon(
                          FontAwesomeIcons.check,
                          color: Colors.green,
                        ),
                        () {}),
                    buttonUI(
                        const Icon(
                          FontAwesomeIcons.circleInfo,
                        ),
                        () {})
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget buttonUI(Icon icon, VoidCallback callback) {
    return InkWell(
      onTap: callback,
      child: SizedBox(width: 40, height: 40, child: icon),
    );
  }
}
