import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failure.dart';
import '../../../shared/data/models/verify_phone_number_model.dart';
import '../../data/models/user_model.dart';
import '../usecases/authenticate_usecase.dart';

abstract class BaseAuthRepository{
Future<Either<Failure, VerifyPhoneNumberModel?>> login(AuthParameters authParameters,
    void Function(PhoneAuthCredential) verificationCompleted,
    void Function(String, int?) codeSent);
Future<Either<Failure, User?>> checkOtp(PhoneAuthCredential phoneAuthCredential);
Future<Either<Failure, UserModel?>> getUserByPhoneNumber(String? phoneNumber);
Future<Either<Failure, void>> saveUserData(UserModel? userModel);
Future<void> signOut();
Stream<User?> authStateChanges();
}
