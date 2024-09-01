import 'package:dartz/dartz.dart';
import 'package:progress_soft_app/features/posts/data/models/posts_model.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/posts_repository.dart';
import '../datasource/posts_datasource.dart';

class PostsRepositoryImp implements BasePostsRepository {
  final BasePostsRemoteDataSource _postsRemoteDataSource;

  PostsRepositoryImp({required BasePostsRemoteDataSource postsRemoteDataSource})
      : _postsRemoteDataSource = postsRemoteDataSource;

  @override
  Future<Either<Failure, List<PostsModel>>> getPosts() async {
    try {
      var response = await _postsRemoteDataSource.getPosts();

      var data = postsModelFromJson(response.data);

      return Right(data);
    } catch (e) {
      return Left(InvalidInputFailure(e.toString()));
    }
  }
}
