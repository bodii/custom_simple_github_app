part of 'app_pages.dart';

abstract class AppRoutes {
  /// Home page
  static const home = '/home';

  /// user page
  static const user = '/user';
  static const signIn = '/user/sign_in';
  static const signUp = '/user/sign_up';
  static const signOut = '/user/sign_out';
  static const forgotPassword = '/user/forgot_password';
  static const repositorySearch = '/repository/search';
  static const repository = '/repository/detail';
  static const filepath = '/repository/filepath/:sha';
  static const content = '/repository/content';
  static const notFound = '/not_found';
}
