import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/posts_model.dart';

abstract class BasePostsRepository{
  Future<Either<Failure, List<PostsModel>>> getPosts();
}
