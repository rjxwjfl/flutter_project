import 'package:flutter/material.dart';

class TitleView extends StatelessWidget {
  const TitleView({required this.titleText, this.subText='', Key? key}) : super(key: key);

  final String titleText;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              titleText,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                letterSpacing: 0.5,
              ),
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            borderRadius:
            const BorderRadius.all(Radius.circular(4.0)),
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Text(
                    "Details",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(
                    height: 38,
                    width: 26,
                    child: Icon(
                      Icons.arrow_forward,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
