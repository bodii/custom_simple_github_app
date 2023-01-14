import 'package:custom_simple_github_app/commons/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'text_animation_widget.dart';
import 'package:go_router/go_router.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () {
            context.goNamed(AppRoutes.home);
          },
          child: const Icon(Icons.home),
        ),
        title: const Text('Sign up'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.black87),
        child: const TextAnimationWidget(),
      ),
    );
  }
}
