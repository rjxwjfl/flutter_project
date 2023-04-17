import 'package:flutter/material.dart';
import 'package:flutter_dowith/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class GetPeriodUI extends StatelessWidget {
  const GetPeriodUI({required this.scheme, Key? key}) : super(key: key);

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat("yy MM/dd");
    return Consumer(builder: (context, ref, child) {
      var refs = ref.watch(prjDrawUpProv);
      return Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(text: "기간", style: TextStyle(color: scheme.onBackground)),
              TextSpan(text: "(선택)", style: TextStyle(color: scheme.outline))
            ])),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  TextButton(
                    style: ElevatedButton.styleFrom(side: BorderSide(color: !refs.period ? scheme.primary : scheme.outline)),
                    onPressed: !refs.period
                        ? () async {
                            refs.initDate = (await showDatePicker(
                                context: context,
                                initialDate: refs.initDate,
                                firstDate: DateTime(2000, 1, 1),
                                lastDate: DateTime(2100, 12, 31)))!;
                          }
                        : null,
                    child: Text(formatter.format(refs.initDate)),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    child: SizedBox(
                      child: Text("-"),
                    ),
                  ),
                  TextButton(
                    style: ElevatedButton.styleFrom(side: BorderSide(color: !refs.period ? scheme.primary : scheme.outline)),
                    onPressed: !refs.period
                        ? () async {
                            refs.endDate = (await showDatePicker(
                                context: context,
                                initialDate: refs.endDate,
                                firstDate: DateTime(2000, 1, 1),
                                lastDate: DateTime(2100, 12, 31)))!;
                          }
                        : null,
                    child: Text(formatter.format(refs.endDate)),
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
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                value: refs.period,
                                onChanged: (value) {
                                  refs.period = value!;
                                },
                              ),
                            ),
                          ),
                          const Text("기간 없음")
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
    });
  }
}
