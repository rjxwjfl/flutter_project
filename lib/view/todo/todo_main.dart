import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoMain extends StatelessWidget {
  const TodoMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: DateFormat("dd").format(today).toString(), style: TextStyle(fontSize: 45, color: Theme.of(context).colorScheme.inverseSurface)
              ),
              TextSpan(
                text: "일",style: TextStyle(fontSize: 25, color: Theme.of(context).colorScheme.inverseSurface)
              ),
            ],
          ),
        ),
      ),
      body: const Placeholder(),
    );
  }
}
