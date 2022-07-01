import 'package:custom_simple_github_app/pages/home/index.dart';
import 'package:custom_simple_github_app/pages/repository/search_list.dart';
import 'package:custom_simple_github_app/pages/user/forgot_password/index.dart';
import 'package:custom_simple_github_app/pages/user/home/index.dart';
import 'package:custom_simple_github_app/pages/user/sign_in/index.dart';
import 'package:custom_simple_github_app/pages/user/sign_out/index.dart';
import 'package:custom_simple_github_app/pages/user/sign_up/index.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

part 'app_routes.dart';

class AppPages {
  static const init = AppRoutes.home;

  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeIndexView(),
    ),
    GetPage(
      name: AppRoutes.user,
      page: () => const UserHomeView(),
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignInIndexView(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignUpView(),
    ),
    GetPage(
      name: AppRoutes.signOut,
      page: () => const SignOutView(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordView(),
    ),
    GetPage(
      name: AppRoutes.repositorySearch,
      page: () => const RepositorySearchListView(),
    )
  ];

  static final unknown = GetPage(
    name: AppRoutes.notFound,
    page: () => const Text('not found'),
  );
}
