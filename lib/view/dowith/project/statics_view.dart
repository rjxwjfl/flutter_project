import 'package:flutter/material.dart';

class StaticsView extends StatelessWidget {
  const StaticsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
      child: Row(
        children: [
          SizedBox(
            width: 150,
              height: 150,
              child: Card(
                elevation: 10.0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("?"),
                ),
              )),
          Expanded(child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("총 과제 수 : :?")
              ],
            ),
          )),
        ],
      ),
    );
  }
}
