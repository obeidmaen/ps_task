import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_localization.dart';
import '../../../../core/ui/custom_text_field.dart';
import '../controller/posts_cubit.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.postsController,
  });

  final PostsCubit postsController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      icon: Icon(
        Icons.search_rounded,
        size: 24.r,
        color: AppColors.primaryColor,
      ),
      controller: postsController.searchController,
      keyboardType: TextInputType.text,
      hintText: AppLocalization.of(context).getTranslatedValues("post_title"),
      onChanged: (value) => postsController.searchPosts(value),
    );
  }
}
