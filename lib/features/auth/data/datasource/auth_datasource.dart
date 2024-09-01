import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/network/firebase_auth_service.dart';
import '../../../../core/network/firestore_service.dart';
import '../../../shared/data/models/verify_phone_number_model.dart';
import '../../domain/usecases/authenticate_usecase.dart';
import '../models/user_model.dart';

abstract class BaseAuthRemoteDataSource {
  Future<VerifyPhoneNumberModel?> login(
      AuthParameters authParameters,
      void Function(PhoneAuthCredential) verificationCompleted,
      void Function(String, int?) codeSent);
  Future<User?> checkOtp(PhoneAuthCredential phoneAuthCredential);
  Future<QuerySnapshot<Map<String, dynamic>>> getUserByPhoneNumber(
      String? phoneNumber);
  Future<void> saveUserData(UserModel? userModel);
  Future<void> signOut();
  Stream<User?> authStateChanges();
}

class AuthRemoteDataSourceImp implements BaseAuthRemoteDataSource {
  final FirebaseAuthService _auth;
  final FirestoreService _firestore;

  AuthRemoteDataSourceImp(this._auth, this._firestore);

  @override
  Future<VerifyPhoneNumberModel?> login(
      AuthParameters authParameters,
      void Function(PhoneAuthCredential) verificationCompleted,
      void Function(String, int?) codeSent) async {
    final response = await _auth.verifyPhoneNumber(
        authParameters.userName, verificationCompleted, codeSent);

    return response;
  }

  @override
  Future<User?> checkOtp(PhoneAuthCredential phoneAuthCredential) async {
    final response = await _auth.signInWithCredential(phoneAuthCredential);

    return response;
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getUserByPhoneNumber(
      String? phoneNumber) async {
    final response =
        await _firestore.getWhereIsEqualTo("users", 'phoneNumber', phoneNumber);

    return response;
  }

  @override
  Future<void> saveUserData(UserModel? userModel) async {
    final response = await _firestore.setDocument(
        "users", userModel?.id ?? "", userModel?.toJson() ?? {});

    return response;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}
