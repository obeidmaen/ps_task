import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../features/shared/data/models/verify_phone_number_model.dart';

class FirebaseAuthService {
  // Private constructor
  FirebaseAuthService._privateConstructor();

  // Singleton instance
  static final FirebaseAuthService _instance =
      FirebaseAuthService._privateConstructor();

  // Factory constructor to return the same instance
  factory FirebaseAuthService() {
    return _instance;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<VerifyPhoneNumberModel?> verifyPhoneNumber(
      String phoneNumber,
      void Function(PhoneAuthCredential) verificationCompleted,
      void Function(String, int?) codeSent) async {
    VerifyPhoneNumberModel? verifyPhoneNumberModel;
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: (firebaseAuthException) {
          if (kDebugMode) {
            print(firebaseAuthException.toString());
          }
        },
        codeSent: codeSent,
        codeAutoRetrievalTimeout: (verificationId) {});

    return verifyPhoneNumberModel;
  }

  Future<User?> signInWithCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    var userCredentials = await _auth.signInWithCredential(phoneAuthCredential);

    return userCredentials.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}
