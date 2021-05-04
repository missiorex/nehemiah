import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'entities/entities.dart';
import 'models/models.dart';

class FirebaseUserRepository implements UsersRepository {
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<bool> isAuthenticated() async {
    final currentUser = await _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<void> authenticate() {
    return _firebaseAuth.signInAnonymously();
  }

  Future<String> getUserId() async {
    return (await _firebaseAuth.currentUser).uid;
  }

  @override
  Future<void> addNewChild(Child child, String userId) {
    return userCollection
        .doc(userId)
        .collection("children")
        .add(child.toEntity().toDocument());
  }

  @override
  Future<void> deleteChild(Child child) async {
    return userCollection.doc(child.id).delete();
  }

  @override
  Future<void> updateChild(Child child) {
    return userCollection.doc(child.id).update(child.toEntity().toDocument());
  }

  @override
  Stream<List<Child>> children(String userId) {
    return userCollection
        .doc(userId)
        .collection("children")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Child.fromEntity(ChildEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
