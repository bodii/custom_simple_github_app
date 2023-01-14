import 'dart:convert';

import 'package:custom_simple_github_app/commons/apis.dart';
import 'package:custom_simple_github_app/models/content.dart';
import 'package:custom_simple_github_app/models/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class RepositoryContentView extends StatefulWidget {
  const RepositoryContentView(this.path, this.repo, this.name, {Key? key})
      : super(key: key);
  final String path;
  final Repo repo;
  final String name;

  @override
  State<RepositoryContentView> createState() => _RepositoryContentViewState();
}

class _RepositoryContentViewState extends State<RepositoryContentView> {
  late Apis apis;
  late Repo repo;
  late String name;
  late String path;

  @override
  void initState() {
    super.initState();
    path = widget.path;
    repo = widget.repo;
    name = widget.name;
    apis = Apis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 35.0,
          horizontal: 25.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   name,
            //   style: const TextStyle(
            //     color: Colors.grey,
            //   ),
            // ),
            Text(
              path,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            getContent(),
          ],
        ),
      ),
    );
  }

  Widget getContent() {
    return FutureBuilder<Content>(
      future: apis.getContent(repo.fullName, path, repo.defaultBranch),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done ||
            !snapshot.hasData ||
            snapshot.hasError) {
          return Container();
        }

        String content = snapshot.data!.content ?? '';
        if (content.isNotEmpty) {
          content = utf8.decode(
              (base64.decode(content.replaceAll(RegExp(r'[\n\s]'), ''))));
        }

        return Expanded(
          child: Markdown(
            data: '```$content```',
            selectable: true,
            extensionSet: md.ExtensionSet(
              md.ExtensionSet.gitHubFlavored.blockSyntaxes,
              [
                md.EmojiSyntax(),
                ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
              ],
            ),
            styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
            styleSheet: MarkdownStyleSheet.fromTheme(ThemeData.dark()),
          ),
        );
      },
    );
  }
}
