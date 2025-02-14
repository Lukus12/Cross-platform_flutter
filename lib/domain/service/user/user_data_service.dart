import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kross/domain/service/user/user_data.dart';
import 'package:kross/domain/service/user/user_data_service_interface.dart';

class UserDataService extends UserDataServiceInterface {
  final CollectionReference users =
  FirebaseFirestore.instance.collection('users');

  @override
  Future<UserData> getUserData() async {
    try {
      return users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((snapshot) async {
        var userData =
        UserData.fromJson(snapshot.data() as Map<String, dynamic>);
        return userData;
      });
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<void> addUserData({
    required String name,
    required String email,
  }) async {
    try {
      await users.doc(FirebaseAuth.instance.currentUser!.uid).set({
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'name': name,
        'email': email,
        'description': '',
        'timestamp': Timestamp.now(),
      });
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<void> updateUserData({
    required String name,
    required String description,
  }) async {
    try {
      await users.doc(FirebaseAuth.instance.currentUser!.uid).update({
        'name': name,
        'description': description,
      });
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<void> deleteUserData() async {
    try {
      await users.doc(FirebaseAuth.instance.currentUser!.uid).delete();
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<void> addToFavorites(String articleId) async {
    try {
      await users.doc(FirebaseAuth.instance.currentUser!.uid).update({
        'favorites': FieldValue.arrayUnion([articleId])
      });
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<void> removeFromFavorites(String articleId) async {
    try {
      await users.doc(FirebaseAuth.instance.currentUser!.uid).update({
        'favorites': FieldValue.arrayRemove([articleId])
      });
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<List<String>> getFavorites() async {
    try {
      final snapshot = await users.doc(FirebaseAuth.instance.currentUser!.uid).get();
      return List<String>.from(snapshot.get('favorites') ?? []);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

}
