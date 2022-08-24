import 'package:custom_simple_github_app/commons/apis.dart';
import 'package:custom_simple_github_app/commons/routes/app_pages.dart';
import 'package:custom_simple_github_app/models/content.dart';
import 'package:custom_simple_github_app/models/repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepositoryFilePathView extends StatefulWidget {
  const RepositoryFilePathView({Key? key}) : super(key: key);

  @override
  State<RepositoryFilePathView> createState() => _RepositoryFilePathViewState();
}

class _RepositoryFilePathViewState extends State<RepositoryFilePathView> {
  late Apis apis;
  late Repo repo;
  late String url;
  late String path;

  @override
  void initState() {
    super.initState();
    apis = Apis();
    path = Get.arguments['path'];
    repo = Get.arguments['repo'];
    url = Get.arguments['url'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(path)),
      body: Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 35.0,
          horizontal: 25.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: getContent()),
          ],
        ),
      ),
    );
  }

  Widget getContent() {
    return FutureBuilder<List<Content>>(
      future: getContents(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done ||
            !snapshot.hasData ||
            snapshot.hasError) {
          return Container();
        }

        return ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    snapshot.data![index].type == 'file'
                        ? Icons.insert_drive_file
                        : Icons.folder,
                    color: Colors.grey,
                    size: 18.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      snapshot.data![index].name,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
              title: const Text(
                // snapshot.data![index].name,
                '',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                debugPrint(snapshot.data![index].url);
                if (snapshot.data![index].type != 'file') {
                  Get.toNamed(
                    AppRoutes.filepath,
                    arguments: {
                      'repo': repo,
                      'path': snapshot.data![index].path,
                      'name': snapshot.data![index].name,
                      'url': snapshot.data![index].url,
                    },
                    parameters: {'a': snapshot.data![index].sha},
                  );
                } else {
                  Get.toNamed(
                    AppRoutes.content,
                    arguments: {
                      'repo': repo,
                      'path': snapshot.data![index].path,
                      'name': snapshot.data![index].name,
                      'url': snapshot.data![index].url,
                    },
                  );
                }
              },
            );
          },
          itemCount: snapshot.data?.length ?? 0,
          separatorBuilder: (context, index) => Divider(
            height: .3,
            color: Colors.grey.shade700,
          ),
        );
      },
    );
  }

  Future<List<Content>> getContents(String url) async {
    List<dynamic> json = await apis.get(url);

    List<Content> contents = [
      for (var c in json) Content.fromJson(c as Map<String, dynamic>)
    ];
    return contents;
  }
}
