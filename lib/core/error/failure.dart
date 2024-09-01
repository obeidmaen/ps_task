import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../config/app_localization.dart';
import '../navigation/app_custom_navigation.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure(DioException? exception) : super(getErrorMessage(exception));
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);

}
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure(super.message);
}


String getErrorMessage(DioException? exception){
  String errorMessage = AppLocalization.of(currentContext!).getTranslatedValues('something_went_wrong');
  if(exception != null){
    try{
      errorMessage = '${exception.response?.data?['Errors']?[0]?['errorMsg']?['message']}';
      if(errorMessage == 'null'){
        errorMessage = AppLocalization.of(currentContext!).getTranslatedValues('something_went_wrong');
      }
    }catch(e){
      errorMessage = "Error";
      if(kDebugMode){
        print(e.toString());
      }
    }
  }
  return errorMessage;
}