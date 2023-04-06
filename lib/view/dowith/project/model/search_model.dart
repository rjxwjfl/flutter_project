import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBarUI extends StatelessWidget {
  const SearchBarUI(
      {required this.controller,
      required this.hintText,
      required this.focusNode,
      this.keyboardType = TextInputType.text,
      super.key});

  final String hintText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: SizedBox(
        height: 35.0,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  keyboardType: keyboardType,
                  onFieldSubmitted: (value){
                    FocusManager.instance.primaryFocus!.unfocus();
                    // Project find request
                  },
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(color: scheme.primary,fontSize: 14),
                    contentPadding: const EdgeInsets.only(left: 12, right: 12),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: scheme.primary,
                          width: 1.0
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: scheme.primary,
                          width: 1.0
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: scheme.primary,
                          width: 1.0
                      ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                FocusManager.instance.primaryFocus!.unfocus();
                // Project find request
              },
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Ink(
                decoration: BoxDecoration(color: scheme.primary, borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
                  child: Icon(FontAwesomeIcons.magnifyingGlass, color: scheme.onPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
