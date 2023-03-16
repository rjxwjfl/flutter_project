import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStorePost{
  final User _user;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  FireStorePost(this._user);
}