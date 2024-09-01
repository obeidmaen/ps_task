import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_soft_app/features/posts/presentation/screens/posts_screen.dart';
import '../../../../core/config/app_localization.dart';
import '../../../../core/config/injection_container.dart';
import '../../../auth/presentation/screens/register_screen.dart';
import '../controller/posts_cubit.dart';

class PostsNavigationScreen extends StatefulWidget {
  static const String route = "PostsNavigationScreen";
  const PostsNavigationScreen({super.key});

  @override
  State<PostsNavigationScreen> createState() => _PostsNavigationScreenState();
}

int sortingSelectedTab = 0;

class _PostsNavigationScreenState extends State<PostsNavigationScreen> {
  final GlobalKey _bottomNavigationKey = GlobalKey(debugLabel: 'label32');

  late List<Navigator> appPageTab;
  late PostsCubit postsController;

  @override
  void initState() {
    super.initState();

    postsController = PostsCubit.get(context);

    sortingSelectedTab = 0;

    appPageTab = [
      Navigator(
        initialRoute: PostsScreen.route,
        onGenerateRoute: (_) {
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (context) => getIt<PostsCubit>(),
                    child: const PostsScreen(),
                  ));
        },
      ),
      Navigator(
        initialRoute: RegisterScreen.route,
        onGenerateRoute: (_) {
          return MaterialPageRoute(builder: (_) => const RegisterScreen(fromProfile: true,));
        },
      ),
    ];
  }

  List<Widget> getPageTap() {
    return List.generate(
      appPageTab.length,
      (index) => appPageTab[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: postsController.scaffoldKey,
      body: IndexedStack(index: sortingSelectedTab, children: getPageTap()),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4.0),
          topRight: Radius.circular(4.0),
        ),
        child: Card(
          elevation: 1.0,
          margin: const EdgeInsets.only(top: 3.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: BottomNavigationBar(
            key: _bottomNavigationKey,
            elevation: 10,
            selectedLabelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            unselectedLabelStyle: Theme.of(context).textTheme.bodyLarge,
            items: [
              _buildBottomNavigationItem(
                Icons.sticky_note_2_rounded,
                AppLocalization.of(context).getTranslatedValues("posts"),
              ),
              _buildBottomNavigationItem(
                Icons.account_circle_rounded,
                AppLocalization.of(context)
                    .getTranslatedValues('profile'),
              ),
            ],
            currentIndex: sortingSelectedTab,
            onTap: (value) {
              setState(() {
                sortingSelectedTab = value;
              });
            },
          ),
        ),
      ),
    );
  }

  _buildBottomNavigationItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(bottom: 14.h),
        child: Icon(
          icon,
          size: 24,
        ),
      ),
      label: label,
    );
  }
}
