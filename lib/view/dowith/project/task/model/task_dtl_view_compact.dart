import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/model/task/task_assigned_view.dart';
import 'package:flutter_dowith/utils/convert_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskDtlViewCompact extends StatefulWidget {
  const TaskDtlViewCompact({required this.data, Key? key}) : super(key: key);

  final TaskAssignedCompactView data;

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
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 60.0
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5, top: 2, bottom: 2),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: 5.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: widget.data.lblClr
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.data.taskSub}>",
                                style: const TextStyle(fontSize: 10),
                              ),
                              Text(widget.data.taskPnt),
                            ],
                          ),
                        ),
                        widget.data.startDate != null ?
                        Column(
                          children: [
                            Text(untilExpire(widget.data.endDate!),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground)),
                            Text(dateFormat.format(widget.data.endDate!),
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.outline,
                                    fontSize: 10),
                            textAlign: TextAlign.center,),
                          ],
                        ) : const SizedBox(),
                      ],
                    ),
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
