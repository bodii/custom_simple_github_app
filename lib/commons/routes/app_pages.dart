import 'package:custom_simple_github_app/models/repo.dart';
import 'package:custom_simple_github_app/pages/home/index.dart';
import 'package:custom_simple_github_app/pages/repository/content.dart';
import 'package:custom_simple_github_app/pages/repository/detail.dart';
import 'package:custom_simple_github_app/pages/repository/filepath.dart';
import 'package:custom_simple_github_app/pages/repository/search_list.dart';
import 'package:custom_simple_github_app/pages/user/forgot_password/index.dart';
import 'package:custom_simple_github_app/pages/user/home/index.dart';
import 'package:custom_simple_github_app/pages/user/sign_in/index.dart';
import 'package:custom_simple_github_app/pages/user/sign_out/index.dart';
import 'package:custom_simple_github_app/pages/user/sign_up/index.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

part 'app_routes.dart';

class AppPages {
  static const init = AppRoutes.home;

  static final List<RouteBase> routes = <RouteBase>[
    GoRoute(
      path: AppRoutes.home,
      name: AppRoutes.home,
      builder: (context, state) => const HomeIndexView(),
    ),
    GoRoute(
      path: AppRoutes.user,
      name: AppRoutes.user,
      builder: (context, state) => const UserHomeView(),
    ),
    GoRoute(
      path: AppRoutes.signIn,
      name: AppRoutes.signIn,
      builder: (context, state) => const SignInIndexView(),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      name: AppRoutes.signUp,
      builder: (context, state) => const SignUpView(),
    ),
    GoRoute(
      path: AppRoutes.signOut,
      name: AppRoutes.signOut,
      builder: (context, state) => const SignOutView(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      name: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordView(),
    ),
    GoRoute(
        path: AppRoutes.repositorySearch,
        name: AppRoutes.repositorySearch,
        builder: (context, state) {
          debugPrint("params: ${state.params.toString()}");
          // String searchText = state.params['searchText'] ?? '';
          String searchText = 'cc';
          return RepositorySearchListView(searchText: searchText);
        }),
    GoRoute(
        path: AppRoutes.repository,
        name: AppRoutes.repository,
        builder: (context, state) {
          String repo = state.params['info'] ?? '';
          return RepositoryDetailView(repo);
        }),
    GoRoute(
        path: AppRoutes.filepath,
        name: AppRoutes.filepath,
        builder: (context, state) {
          String path = state.params['path'] ?? '';
          Repo repo = state.params['repo'] as Repo;
          String url = state.params['name'] ?? '';
          return RepositoryFilePathView(path, repo, url);
        }),
    GoRoute(
        path: AppRoutes.content,
        name: AppRoutes.content,
        builder: (context, state) {
          String path = state.params['path'] ?? '';
          Repo repo = state.params['repo'] as Repo;
          String name = state.params['name'] ?? '';
          return RepositoryContentView(path, repo, name);
        }),
  ];

  static final Text Function(BuildContext context, GoRouterState state)
      unknown = (context, state) => const Text('not found');
}
