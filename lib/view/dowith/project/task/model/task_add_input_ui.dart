import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskAddInputUI extends StatefulWidget {
  const TaskAddInputUI(
      {required this.title,
      required this.hint,
      required this.controller,
      required this.focusNode,
      required this.validator,
      this.length = 50,
      Key? key})
      : super(key: key);

  final String title;
  final String hint;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(String?) validator;
  final int length;

  @override
  State<TaskAddInputUI> createState() => _TaskAddInputUIState();
}

class _TaskAddInputUIState extends State<TaskAddInputUI> {
  bool _showClearIcon = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        _showClearIcon = widget.controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 5, 18, 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title),
          SizedBox(
            height: 55,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: widget.controller,
              focusNode: widget.focusNode,
              validator: widget.validator,
              maxLength: widget.length,
              onChanged: (value) {
                setState(() {
                  _showClearIcon = value.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: TextStyle(fontSize: 12),
                // contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                suffixIcon: _showClearIcon
                    ? IconButton(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          widget.controller.clear();
                        },
                        icon: const Icon(
                          FontAwesomeIcons.xmark,
                          size: 18,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
