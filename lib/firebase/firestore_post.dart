import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dowith/bloc/database_bloc/userCtrl/auth.dart';
import 'package:flutter_dowith/firebase/model/post_model.dart';
import 'package:uuid/uuid.dart';

class FireStorePost {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User _user = Auth().auth.currentUser!;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamPosts() {
    final postPath = _firestore.collection("post");
    return postPath
        .orderBy('createdAt', descending: true)
        .limit(20)
        .snapshots();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getPosts() async {
    final postPath = _firestore.collection("post");
    final snapshot =
        await postPath.orderBy('createdAt', descending: true).limit(20).get();
    return snapshot.docs;
  }

  void createPost(PostModel post) async {
    final postPath = _firestore.collection("post");
    postPath.doc(post.id).set(post.toMap());
  }

  void editPost(PostModel data) async {
    final postPath = _firestore.collection("post");
  }

  String generateUuid() {
    var uuid = const Uuid().v4();
    String genUuid = uuid.replaceAll('-', '');
    return genUuid;
  }
}
