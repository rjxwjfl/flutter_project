import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dowith/firebase/auth.dart';
import 'package:flutter_dowith/firebase/model/post_model.dart';
import 'package:uuid/uuid.dart';

class FireStorePost{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User _user = Auth().auth.currentUser!;

  void createPost(PostModel data) async{
    final postPath = _firestore.collection("post");
    postPath.doc(data.id).set(data.toMap());
  }

  void editPost(PostModel data) async{
    final postPath = _firestore.collection("post");

  }

  String generateUuid(){
    var uuid = const Uuid().v4();
    String genUuid = uuid.replaceAll('-', '');
    return genUuid;
  }
}