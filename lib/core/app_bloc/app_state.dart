part of 'app_bloc.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class LoadingState extends AppState {}

class FailedState extends AppState {
  final String message;
  FailedState(this.message);
}
