import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class TodoTimeIndicator extends StatelessWidget {
  const TodoTimeIndicator({required this.time, Key? key}) : super(key: key);

  final DateTime time;

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat("hh:mm");
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  color: time.hour < 13 ? scheme.onPrimary : scheme.primary.withOpacity(0.5),
                ),
                color: time.hour < 13 ? scheme.primary : scheme.background.withOpacity(0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                child: Text(
                  "AM",
                  style: TextStyle(
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.w600,
                    fontSize: 9,
                    color: time.hour < 13 ? scheme.onPrimary : scheme.primary.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  color: time.hour > 12 ? scheme.onPrimary : scheme.primary.withOpacity(0.5),
                ),
                color: time.hour > 12 ? scheme.primary : scheme.background.withOpacity(0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                child: Text(
                  "PM",
                  style: TextStyle(
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.w600,
                    fontSize: 9,
                    color: time.hour > 12 ? scheme.onPrimary : scheme.primary.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Center(
                    child: Text(
              formatter.format(time),
              style: const TextStyle(fontFamily: "QuickSand", fontWeight: FontWeight.w500),
            )))
          ],
        ),
      ),
    );
  }
}
