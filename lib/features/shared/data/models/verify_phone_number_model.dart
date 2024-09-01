import 'package:firebase_auth/firebase_auth.dart';

class VerifyPhoneNumberModel {
  PhoneAuthCredential? phoneAuthCredential;
  String? verificationId;

  VerifyPhoneNumberModel({this.phoneAuthCredential, this.verificationId});
}
