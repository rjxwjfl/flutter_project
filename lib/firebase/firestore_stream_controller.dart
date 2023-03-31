import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreStreamController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _uid;

  FirestoreStreamController(this._uid);

  // Stream to listen for changes in userDetails and userEssential docs
  Stream<Map<String, dynamic>> getUserProfileStream() {
    return _firestore.collection('user').doc(_uid).collection('userData').snapshots().map((snapshot) {
      return {
        'userDetails': snapshot.docs[0].data(),
        'userEssential': snapshot.docs[1].data(),
      };
    });
  }

}
