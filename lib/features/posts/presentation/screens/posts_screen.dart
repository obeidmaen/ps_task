import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_soft_app/core/config/app_colors.dart';
import 'package:progress_soft_app/core/config/context_extensions.dart';
import 'package:progress_soft_app/features/posts/presentation/controller/posts_cubit.dart';
import 'package:progress_soft_app/features/posts/presentation/controller/posts_state.dart';
import 'package:progress_soft_app/features/posts/presentation/widgets/posts_card_widget.dart';

import '../../../../core/config/app_localization.dart';
import '../../../../core/ui/custom_loading_indicator.dart';
import '../widgets/search_field.dart';

class PostsScreen extends StatefulWidget {
  static String route = "PostsScreen";
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late PostsCubit postsController;

  @override
  void initState() {
    postsController = PostsCubit.get(context);
    postsController.getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalization.of(context).getTranslatedValues("posts"),
            style: context.titleLargeTextStyle20
                ?.copyWith(color: AppColors.primaryColor),
          ),
        ),
        body: BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0).r,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                children: [
                  SearchField(
                    postsController: postsController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(AppLocalization.of(context)
                              .getTranslatedValues("count") +
                          " " +
                          postsController.searchedPosts.length.toString()),
                    ],
                  ),
                  state is GetDataLoading
                      ? const Center(
                          child: CustomLoadingIndicator(),
                        )
                      : state is GetDataError
                          ? Padding(
                            padding: EdgeInsets.only(top: 100.h),
                            child: Center(
                                child: Text(AppLocalization.of(context)
                                    .getTranslatedValues(state.message)),
                              ),
                          )
                          : Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: postsController.searchedPosts
                                      .map((element) => PostCardWidget(
                                          title: element.title,
                                          body: element.body))
                                      .toList(),
                                ),
                              ),
                            ),
                ],
              ),
            ),
          );
        }));
  }
}
