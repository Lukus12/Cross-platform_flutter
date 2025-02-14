import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signUp(String email, String password) async {
    final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Получаем UID нового пользователя
    final String userId = userCredential.user!.uid;

    // Создаем документ пользователя в Firestore с пустым списком избранного
    await _firestore.collection('users').doc(userId).set({
      'favorites': [], // Инициализируем пустой массив для избранных элементов
    });

    return userCredential;
  }

  Future<UserCredential> logIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();
}