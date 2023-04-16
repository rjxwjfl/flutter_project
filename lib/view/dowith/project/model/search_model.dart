import 'package:flutter/material.dart';
import 'package:flutter_dowith/bloc/database_bloc/project/project_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBarUI extends StatelessWidget {
  const SearchBarUI(
      {required this.controller,
      required this.hintText,
      required this.focusNode,
      this.bloc,
      required this.color,
      required this.callback,
        required this.removeCallback,
      this.keyboardType = TextInputType.text,
      super.key});

  final String hintText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final ProjectBloc? bloc;
  final Color color;
  final void Function(String?) callback;
  final void Function() removeCallback;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      height: kToolbarHeight * 0.7,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: color, borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: SizedBox(
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            onFieldSubmitted: callback,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: scheme.primary, fontSize: 14),
              contentPadding: const EdgeInsets.only(left: 12, right: 12),
              prefixIcon: IconButton(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 18,
                  )),
              suffixIcon: controller.value.text.isNotEmpty
                  ? IconButton(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: removeCallback,
                      icon: const Icon(
                        FontAwesomeIcons.xmark,
                        size: 18,
                      ))
                  : null,
              // add state...?
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: scheme.primary, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: scheme.primary, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: scheme.primary, width: 1.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
