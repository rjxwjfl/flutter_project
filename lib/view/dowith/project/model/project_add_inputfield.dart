import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectAddInputField extends StatefulWidget {
  const ProjectAddInputField(
      {required this.title, required this.hint, required this.controller, required this.focusNode, required this.validator, this.length = 50, Key? key})
      : super(key: key);

  final String title;
  final String hint;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(String?) validator;
  final int length;

  @override
  State<ProjectAddInputField> createState() => _ProjectAddInputFieldState();
}

class _ProjectAddInputFieldState extends State<ProjectAddInputField> {
  bool _showClearIcon = false;
  int length = 0;
  
  Color _lengthValidate(context, int length){
    if (length > widget.length) {
      return Theme.of(context).colorScheme.error;
    }
    return Theme.of(context).colorScheme.onBackground;
  }

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
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(widget.title)),
              RichText(text: TextSpan(
                children: [
                  TextSpan(text: "$length", style: TextStyle(color: _lengthValidate(context, length), fontFamily: "QuickSand")),
                  TextSpan(text: "/${widget.length}", style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontFamily: "QuickSand"))
                ],
              ),),
            ],
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            controller: widget.controller,
            focusNode: widget.focusNode,
            validator: widget.validator,
            onChanged: (value) {
              setState(() {
                _showClearIcon = value.isNotEmpty;
                length = widget.controller.text.length;
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
                        setState(() {
                          length = 0;
                        });
                      },
                      icon: const Icon(
                        FontAwesomeIcons.xmark,
                        size: 18,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
