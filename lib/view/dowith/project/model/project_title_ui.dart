import 'package:flutter/material.dart';

class ProjectTitleUI extends StatelessWidget {
  const ProjectTitleUI({required this.title, this.subText, required this.callback, Key? key}) : super(key: key);

  final String title;
  final String? subText;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 5, 8, 20),
      child: SizedBox(
        child: Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: title,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          letterSpacing: 0.85,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    TextSpan(
                      text: subText,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.outline),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: callback,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "전체보기",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
