import 'package:flutter/material.dart';

import 'text_animation_widget.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black87),
        child: const TextAnimationWidget(),
      ),
    );
  }
}
