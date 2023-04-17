import 'package:flutter/material.dart';

class ButtonUI extends StatelessWidget {
  const ButtonUI({required this.scheme, required this.title, Key? key}) : super(key: key);

  final ColorScheme scheme;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: scheme.onPrimary,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              blurRadius: 8,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Center(
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: scheme.primary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
