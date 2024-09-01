import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/network/firestore_service.dart';

abstract class BaseSplashRemoteDataSource {
  Future<DocumentSnapshot<Object?>> getSystemConfig();
}

class SplashRemoteDataSourceImp implements BaseSplashRemoteDataSource {
  final FirestoreService _firestore;

  SplashRemoteDataSourceImp(this._firestore);

  @override
  Future<DocumentSnapshot<Object?>> getSystemConfig() async {
    final response =
    await _firestore.getDocument("configurations", " system_configuration");

    return response;
  }
}


