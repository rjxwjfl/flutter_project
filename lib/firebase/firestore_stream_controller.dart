import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreStreamController {
  final _userDataStreamController = StreamController<DocumentSnapshot>();
  final _userGroupStreamController = StreamController<DocumentSnapshot>();
  final _userPostStreamController = StreamController<DocumentSnapshot>();
  final _groupStreamController = StreamController<DocumentSnapshot>();
  final _postStreamController = StreamController<DocumentSnapshot>();
  final _groupPostStreamController = StreamController<DocumentSnapshot>();

  Stream<DocumentSnapshot> get userDataStream => _userDataStreamController.stream;
  Stream<DocumentSnapshot> get userGroupStream => _userGroupStreamController.stream;
  Stream<DocumentSnapshot> get userPostStream => _userPostStreamController.stream;
  Stream<DocumentSnapshot> get groupStream => _groupStreamController.stream;
  Stream<DocumentSnapshot> get postStream => _postStreamController.stream;
  Stream<DocumentSnapshot> get groupPostStream => _groupPostStreamController.stream;

  final String _uid;

  FireStoreStreamController(this._uid) {
    // <---------- User Section ---------->
    // groupIDs subcollection
    FirebaseFirestore.instance.collection('user').doc(_uid).collection('groupIDs').snapshots().listen((querySnapshot) {
      for (var change in querySnapshot.docChanges) {
        FirebaseFirestore.instance.collection('group').doc(change.doc.id).snapshots().listen((docSnapshot) {
          _userGroupStreamController.add(docSnapshot);
        });
      }
    });

    // postIDs subcollection
    FirebaseFirestore.instance.collection('user').doc(_uid).collection('postIDs').snapshots().listen((querySnapshot) {
      for (var change in querySnapshot.docChanges) {
        FirebaseFirestore.instance.collection('post').doc(change.doc.id).snapshots().listen((docSnapshot) {
          _userPostStreamController.add(docSnapshot);
        });
      }
    });

    // userData subcollection
    FirebaseFirestore.instance.collection('user').doc(_uid).collection('userData').snapshots().listen((querySnapshot) {
      for (var change in querySnapshot.docChanges) {
        print(change.doc.id);
        _userDataStreamController.add(change.doc);
      }
    });

    // <---------- User Section ---------->


    // group collection
    FirebaseFirestore.instance.collection('group').snapshots().listen((querySnapshot) {
      for (var change in querySnapshot.docChanges) {
        _groupStreamController.add(change.doc);
      }
    });

    // post collection
    FirebaseFirestore.instance.collection('post').snapshots().listen((querySnapshot) {
      for (var change in querySnapshot.docChanges) {
        _postStreamController.add(change.doc);
      }
    });

    // group_post collection
    FirebaseFirestore.instance.collection('group_post').snapshots().listen((querySnapshot) {
      for (var change in querySnapshot.docChanges) {
        _groupPostStreamController.add(change.doc);
      }
    });
  }

  void dispose() {
    _userDataStreamController.close();
    _groupStreamController.close();
    _postStreamController.close();
    _groupPostStreamController.close();
  }
}
