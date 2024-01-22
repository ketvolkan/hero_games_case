import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/auth_models/login_model.dart';
import '../models/auth_models/register_model.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn({required LoginModel loginModel}) async {
    var user = await _auth.signInWithEmailAndPassword(email: loginModel.email ?? "", password: loginModel.password ?? "");
    return user.user;
  }

  signOut() async {
    return await _auth.signOut();
  }

  Future<User?> register({required RegisterModel registerModel}) async {
    var user = await _auth.createUserWithEmailAndPassword(email: registerModel.email ?? "", password: registerModel.password ?? "");
    await _firestore.collection("Person").doc(user.user!.uid).set({'userName': registerModel.name, 'email': registerModel.email});
    return user.user;
  }
}
