import 'package:flutter/material.dart';

@immutable
abstract class SplashState {}

class InitialState extends SplashState {}

class GetDataSuccess extends SplashState {}

class GetDataLoading extends SplashState {}

class GetDataError extends SplashState {
  final String message;

  GetDataError(this.message);
}
