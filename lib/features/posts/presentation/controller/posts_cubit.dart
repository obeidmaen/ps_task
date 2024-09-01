import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/core/config/usecase.dart';
import '../../../../../../core/error/failure.dart';
import '../../data/models/posts_model.dart';
import '../../domain/usecases/posts_usecase.dart';
import 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit({
    required GetPostsUseCase getPostsUseCase,
  })  : _getPostsUseCase = getPostsUseCase,
        super(InitialState());

  final GetPostsUseCase _getPostsUseCase;

  static PostsCubit get(context) => BlocProvider.of<PostsCubit>(context);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController searchController = TextEditingController();

  List<PostsModel> posts = [];
  List<PostsModel> searchedPosts = [];

  Future<void> getPosts() async {
    emit(GetDataLoading());
    Either<Failure, List<PostsModel>> data = await _getPostsUseCase(NoParams());

    data.fold((l) {
      emit(GetDataError("something_went_wrong"));
    }, (r) {
      posts = r;
      searchedPosts = r;
      emit(GetDataSuccess());
    });
  }

  void searchPosts(String? title) {
    if (title != null && title.isNotEmpty) {
      searchedPosts = posts.where((item) {
        return item.title != null &&
            item.title!.isNotEmpty &&
            item.title!.toLowerCase().contains(title.toLowerCase().trim());
      }).toList();
    } else {
      searchedPosts = posts;
    }
    emit(NewSearchResult());
  }
}
