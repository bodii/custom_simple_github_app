import 'package:custom_simple_github_app/models/repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepositoryDetailView extends StatelessWidget {
  const RepositoryDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Repo repo = Get.arguments['info'];

    return Scaffold(
      appBar: AppBar(title: Text(repo.fullName)),
      body: Container(
        child: const Text('repository detail'),
      ),
    );
  }
}
