import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GetPeriodUI extends StatelessWidget {
  const GetPeriodUI({required this.periodExist, required this.scheme, Key? key}) : super(key: key);

  final bool periodExist;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat("yy MM/dd");
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("기간 (선택)"),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                TextButton(
                  style: ElevatedButton.styleFrom(side: BorderSide(color: periodExist ? scheme.primary : scheme.outline)),
                  onPressed: periodExist
                      ? () async {
                    initDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000, 1, 1),
                        lastDate: DateTime(2100, 12, 31));
                  }
                      : null,
                  child: Text("${initDate ?? formatter.format(DateTime.now())}"),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: SizedBox(
                    child: Text("-"),
                  ),
                ),
                TextButton(
                  style: ElevatedButton.styleFrom(side: BorderSide(color: periodExist ? scheme.primary : scheme.outline)),
                  onPressed: periodExist
                      ? () async {
                    expireDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000, 1, 1),
                        lastDate: DateTime(2100, 12, 31));
                  }
                      : null,
                  child: Text("${expireDate ?? formatter.format(DateTime.now())}"),
                ),
                Expanded(
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Transform.scale(
                            scale: 0.7,
                            child: Checkbox(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                              value: !periodExist,
                              onChanged: (value) {
                                setState(() {
                                  periodExist = !periodExist;
                                });
                                print(periodExist);
                              },
                            ),
                          ),
                        ),
                        Text("기간 없음")
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
