import 'package:dartz/dartz.dart';
import '../../../../core/config/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/posts_model.dart';
import '../repositories/posts_repository.dart';

class GetPostsUseCase extends UseCase<List<PostsModel>, NoParams> {
  final BasePostsRepository _postsRepository;

  GetPostsUseCase({required BasePostsRepository postsRepository}) : _postsRepository = postsRepository;

  @override
  Future<Either<Failure, List<PostsModel>>> call(NoParams params) async {
    return await _postsRepository.getPosts();
  }
}