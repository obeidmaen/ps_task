import 'package:flutter/material.dart';

@immutable
abstract class PostsState {}

class InitialState extends PostsState {}

class GetDataSuccess extends PostsState {}

class GetDataLoading extends PostsState {}

class NewSearchResult extends PostsState {}

class GetDataError extends PostsState {
  final String message;

  GetDataError(this.message);
}
