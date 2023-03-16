import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dowith/firebase/auth.dart';

class FireStoreGroup{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User _user = Auth().auth.currentUser!;
}