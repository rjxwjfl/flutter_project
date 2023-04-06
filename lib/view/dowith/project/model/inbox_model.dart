import 'package:flutter/material.dart';

class InboxModel extends StatelessWidget {
  const InboxModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 3, 12, 3),
      child: Card(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => const ProjectHome()));
          },
          child: Ink(
            width: MediaQuery.of(context).size.width,
            height: 75,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Row(
                children: [
                  Container(
                    color: Theme.of(context).colorScheme.primary,
                    width: 75,
                    height: MediaQuery.of(context).size.height,
                  ),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Chat Contents"), Text("lately"), Text("A : what?"), Text("Time : 23-03-31 17:42")],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
