import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dowith/firebase/auth.dart';
import 'package:flutter_dowith/firebase/model/post_model.dart';
import 'package:uuid/uuid.dart';

class FireStoreUser {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User _user = Auth().auth.currentUser!;

  FireStoreUser();

  void createUserData() async {
    final userDataPath = _firestore.collection("user").doc(_user.uid);

    Map<String, dynamic> userEssentialData = {
      "uId": _user.uid,
      "email": _user.email,
      "joinDate": DateTime.now().millisecondsSinceEpoch
    };

    Map<String, dynamic> userDetails = {
      "displayName": _user.displayName,
      "image": null,
      "comment": null,
    };

    final userDataPathLow = userDataPath.collection("userData");
    final groupIDsPath = userDataPath.collection("groupIDs");
    final postIDsPath = userDataPath.collection("postIDs");

    await userDataPathLow.doc("userEssential").set(userEssentialData);
    await userDataPathLow.doc("userDetails").set(userDetails);
    await groupIDsPath.doc("groupIDs").set({});
    await postIDsPath.doc("postIDs").set({});
  }

  void configUserDtl(String displayName, String url, String comment) async {
    final userDtlPath = _firestore
        .collection("user")
        .doc(_user.uid)
        .collection("userData")
        .doc("userDetails");

    Map<String, dynamic> data = (await userDtlPath.get()).data()!;


    data["displayName"] = displayName;
    data["image"] = url;
    data["comment"] = comment;

    userDtlPath.update(data);
  }

  void createPost(PostModel data) async{
    final postPath = _firestore.collection("post");
    postPath.doc(data.title).set(data.toMap());
  }

  String generateUuid(){
    var uuid = const Uuid().v4();
    String genUuid = uuid.replaceAll('-', '');
    return genUuid;
  }
}
