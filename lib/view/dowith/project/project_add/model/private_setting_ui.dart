import 'package:flutter/material.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SetPrivateUI extends StatefulWidget {
  const SetPrivateUI(
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
  State<SetPrivateUI> createState() => _SetPrivateUIState();
}

class _SetPrivateUIState extends State<SetPrivateUI> {
  bool _showClearIcon = false;
  int length = 0;

  Color _lengthValidate(context, int length) {
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
    return Consumer(
      builder: (context, ref, child) {
        bool isPrivate = ref.watch(drawUp).isPrivate;
        return Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(widget.title)),
                  length > 0
                      ? RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "$length",
                                  style: TextStyle(
                                      color: _lengthValidate(context, length),
                                      fontFamily: "QuickSand")),
                              TextSpan(
                                  text: "/${widget.length}",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontFamily: "QuickSand"))
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {},
                        onLongPress: () {
                          isPrivate = !isPrivate;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: isPrivate
                              ? const Icon(FontAwesomeIcons.lockOpen, size: 20,)
                              : const Icon(FontAwesomeIcons.lock, size: 20,),
                        )),
                  ),
                  isPrivate
                      ? Expanded(
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.visiblePassword,
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
                              hintStyle: const TextStyle(fontSize: 12),
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
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}
