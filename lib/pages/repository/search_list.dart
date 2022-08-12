import 'package:custom_simple_github_app/commons/apis.dart';
import 'package:custom_simple_github_app/commons/functions.dart';
import 'package:custom_simple_github_app/commons/globals.dart';
import 'package:custom_simple_github_app/commons/routes/app_pages.dart';
import 'package:custom_simple_github_app/models/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RepositorySearchListView extends StatefulWidget {
  const RepositorySearchListView({Key? key}) : super(key: key);

  @override
  State<RepositorySearchListView> createState() =>
      _RepositorySearchListViewState();
}

class _RepositorySearchListViewState extends State<RepositorySearchListView> {
  String searchText = Get.arguments;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    searchController.text = searchText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Repo search list')),
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
            Row(
              children: [
                SizedBox(
                  width: 300.0,
                  height: 35.0,
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: .6,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: .6,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    cursorColor: Colors.white,
                    minLines: 1,
                    maxLines: 1,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                    ],
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          searchText = value;
                        });
                      }
                    },
                  ),
                ),
                Container(
                  height: 35.0,
                  margin: const EdgeInsets.only(left: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (searchController.text.isNotEmpty) {
                        setState(() {
                          searchText = searchController.text;
                        });
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: const Text('搜索内容不能为空！'),
                              actions: [
                                OutlinedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('关闭'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey.shade900,
                    ),
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white60,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
              child: Text(
                '3 repository results',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20.0,
                ),
              ),
            ),
            Expanded(
              child: getRepoItemList(searchText),
            ),
          ],
        ),
      ),
    );
  }

  Widget getRepoItemList(String searchText) {
    Apis apis = Apis();
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<List<Repo>> snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.hasError) {
          return const Text('not found!');
        }

        return ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) {
            return RepoItem(repo: snapshot.data![index]);
          },
        );
      },
      future: apis.querySearchRepoContext(searchText),
    );
  }
}

class RepoItem extends StatelessWidget {
  const RepoItem({
    Key? key,
    this.repo,
  }) : super(key: key);

  final Repo? repo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 1.5,
          color: Colors.white38,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.book,
                    color: Colors.white54,
                    size: 18.0,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 235.0,
                          minWidth: 50.0,
                        ),
                        child: Text(
                          repo!.fullName,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    onTap: () {
                      debugPrint('click');
                    },
                  ),
                  Container(
                    width: 30.0,
                    height: 18.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.white60, width: .6),
                    ),
                    child: Text(
                      repo!.visibility,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 8.0,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 85.0,
                height: 26.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey.shade900,
                    padding: const EdgeInsets.all(0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        Icons.favorite_border,
                        color: Colors.pinkAccent,
                        size: 18.0,
                      ),
                      Text(
                        'Sponsor',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 23.5, top: 2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Visibility(
                visible: repo!.description != null,
                child: Text(
                  repo!.description ?? '',
                  style: const TextStyle(
                    color: Colors.white60,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Wrap(
                  spacing: 3.0,
                  runSpacing: 1.0,
                  children: [
                    for (String topic in repo!.topics) topicItem(topic)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Visibility(
                      visible: repo!.watchersCount > 0,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_border,
                            color: Colors.white60,
                            size: 16.0,
                          ),
                          Text(
                            Funcs.intToUnit(repo!.watchersCount, 1000, 'k'),
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 11.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: repo!.language != null,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 10.0,
                              height: 10.0,
                              decoration: BoxDecoration(
                                color: Globals.getLanguageColor(repo!.language),
                                shape: BoxShape.circle,
                              ),
                              margin: const EdgeInsets.only(right: 4.0),
                            ),
                            Text(
                              '${repo!.language}',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 11.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: repo!.license != null,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${repo!.license?['spdx_id']} license',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Updated ${Funcs.dateDiff(repo!.updatedAt)}',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: repo!.openIssuesCount > 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${repo!.openIssuesCount} issue needs help ',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget topicItem(String topic) {
  return Container(
    height: 20.0,
    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
    margin: const EdgeInsets.all(1.0),
    decoration: BoxDecoration(
      color: Colors.blue.withOpacity(.2),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Text(
      topic,
      style: const TextStyle(
        color: Colors.blue,
        fontSize: 11.0,
      ),
    ),
  );
}
