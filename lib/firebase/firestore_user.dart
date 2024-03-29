import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dowith/bloc/database_bloc/userCtrl/auth.dart';

class FireStoreUser {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User _user = Auth().auth.currentUser!;

  Future<bool> userExistCheck(path) async {
    DocumentSnapshot<Map<String, dynamic>> docs =
        await _firestore.collection('user').doc(path).collection('userData').doc('userEssential').get();
    if (docs.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future createUserData() async {
    final userDataPath = _firestore.collection("user").doc(_user.uid);

    Map<String, dynamic> userEssentialData = {"uId": _user.uid, "joinDate": DateTime.now().millisecondsSinceEpoch};

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

    return null;
  }

  void configUserDtl(String displayName, String url, String comment) async {
    final userDtlPath = _firestore.collection("user").doc(_user.uid).collection("userData").doc("userDetails");

    Map<String, dynamic> data = (await userDtlPath.get()).data()!;

    data["displayName"] = displayName;
    data["image"] = url;
    data["comment"] = comment;

    userDtlPath.update(data);
  }
}
