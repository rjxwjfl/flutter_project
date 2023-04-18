import 'package:flutter/material.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RuleInput extends StatefulWidget {
  const RuleInput(
      {required this.title, required this.hint, required this.controller, required this.focusNode, this.length = 50, Key? key})
      : super(key: key);

  final String title;
  final String hint;
  final TextEditingController controller;
  final FocusNode focusNode;
  final int length;

  @override
  State<RuleInput> createState() => _RuleInputState();
}

class _RuleInputState extends State<RuleInput> {
  late final ScrollController _scrollController;
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
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Consumer(
      builder: (context, ref, child) {
        var refs = ref.watch(drawUp);
        return Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "규칙 ",
                                style: TextStyle(color: scheme.onBackground),
                              ),
                              TextSpan(
                                text: "(${refs.ruleList.length}",
                                style:
                                    TextStyle(fontSize: 12, color: refs.ruleList.length >= 5 ? Colors.redAccent : scheme.outline),
                              ),
                              TextSpan(
                                text: "/5)",
                                style: TextStyle(fontSize: 12, color: scheme.outline),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  length > 0
                      ? RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "$length",
                                style: TextStyle(color: _lengthValidate(context, length), fontFamily: "QuickSand"),
                              ),
                              TextSpan(
                                text: "/${widget.length}",
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontFamily: "QuickSand"),
                              )
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 150.0),
                child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: refs.ruleList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Row(
                          children: [
                            Text("${index + 1}. "),
                            Expanded(child: Text(refs.ruleList[index])),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      refs.removeList(index);
                                    },
                                    icon: const Icon(
                                      FontAwesomeIcons.xmark,
                                      color: Colors.redAccent,
                                      size: 20,
                                    )),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
              refs.editable
                  ? Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            autofocus: true,
                            textAlignVertical: TextAlignVertical.center,
                            controller: widget.controller,
                            focusNode: widget.focusNode,
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
                        ),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              refs.addList(widget.controller.text);
                              refs.ruleLengthCheck();
                              refs.editable = !refs.editable;
                              widget.controller.clear();
                              setState(() {
                                length = 0;
                              });
                            },
                            icon: const Icon(
                              FontAwesomeIcons.check,
                              size: 20,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              refs.ruleLengthCheck();
                              refs.editable = !refs.editable;
                              widget.controller.clear();
                              setState(() {
                                length = 0;
                              });
                            },
                            icon: const Icon(
                              FontAwesomeIcons.xmark,
                              size: 20,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      child: Center(
                        child: TextButton(
                          onPressed: !refs.isLimit
                              ? () {
                                  refs.editable = !refs.editable;
                                }
                              : null,
                          child: const Text("규칙 추가"),
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
