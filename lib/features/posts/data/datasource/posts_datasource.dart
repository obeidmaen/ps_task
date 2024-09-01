import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/progress_soft_rest.dart';

abstract class BasePostsRemoteDataSource {
  Future<Response> getPosts();
}

class PostsRemoteDataSourceImp implements BasePostsRemoteDataSource {
  final ProgressSoftRest _appRest;

  PostsRemoteDataSourceImp(this._appRest);

  @override
  Future<Response> getPosts() async {
    final response = await _appRest.get("posts");

    return response;
  }
}
