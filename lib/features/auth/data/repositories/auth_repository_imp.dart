import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failure.dart';
import '../../../shared/data/models/verify_phone_number_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/authenticate_usecase.dart';
import '../datasource/auth_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImp implements BaseAuthRepository {
  final BaseAuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImp({required BaseAuthRemoteDataSource authRemoteDataSource})
      : _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<Either<Failure, VerifyPhoneNumberModel?>> login(
      AuthParameters authParameters,
      void Function(PhoneAuthCredential) verificationCompleted,
      void Function(String, int?) codeSent) async {
    try {
      var data = await _authRemoteDataSource.login(
          authParameters, verificationCompleted, codeSent);

      return Right(data);
    } on DioException catch (e) {
      return Left(InvalidInputFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> checkOtp(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      var data = await _authRemoteDataSource.checkOtp(phoneAuthCredential);

      return Right(data);
    } catch (e) {
      return Left(InvalidInputFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel?>> getUserByPhoneNumber(
      String? phoneNumber) async {
    try {
      var response =
          await _authRemoteDataSource.getUserByPhoneNumber(phoneNumber);

      UserModel? data;

      if (response.docs.isNotEmpty) {
        data = userModelFromJson(response.docs.first.data());
      }

      return Right(data);
    } catch (e) {
      return Left(InvalidInputFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserData(UserModel? userModel) async {
    try {
      var response = await _authRemoteDataSource.saveUserData(userModel);

      return Right(response);
    } catch (e) {
      return Left(InvalidInputFailure(e.toString()));
    }
  }

  @override
  Future<void> signOut() async {
    await _authRemoteDataSource.signOut();
  }

  @override
  Stream<User?> authStateChanges() {
    return _authRemoteDataSource.authStateChanges();
  }
}
