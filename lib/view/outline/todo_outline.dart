import 'package:flutter/material.dart';
import 'package:flutter_dowith/firebase/auth.dart';

class TodoOutline extends StatefulWidget {
  const TodoOutline({Key? key}) : super(key: key);

  @override
  State<TodoOutline> createState() => _TodoOutlineState();
}

class _TodoOutlineState extends State<TodoOutline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          Auth().signOutSession();
        }, child: const Text("SignOut"),),
      ),
    );
  }
}
