import 'package:custom_simple_github_app/commons/apis.dart';
import 'package:custom_simple_github_app/commons/routes/app_pages.dart';
import 'package:custom_simple_github_app/models/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RepositorySearchListView extends StatelessWidget {
  const RepositorySearchListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String searchText = Get.arguments;
    TextEditingController searchController =
        TextEditingController(text: searchText);

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
                  ),
                ),
                Container(
                  height: 35.0,
                  margin: const EdgeInsets.only(left: 10.0),
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed(
                      AppRoutes.repositorySearch,
                      arguments: searchText,
                    ),
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
        print(snapshot.data?.length);

        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.hasError) {
          return const Text('not found!');
        }

        print(snapshot.data);

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
  RepoItem({
    Key? key,
    this.repo,
  }) : super(key: key);

  final Repo? repo;

  final List<String> topics = [
    'chart',
    'visualization',
    'pie-chart',
    'charting-library',
    'webview',
    'highcharts',
    'graphics',
    'dynamic',
    'draw',
    'area-chart',
    'radar-chart',
    'hybrid',
    'bubble-chart',
    'line-charts',
    'ios-charts',
    'column-chart',
    'polar-chart',
    'stacked-chart',
    'chart-types',
    'support-graphics',
  ];

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
                      padding: const EdgeInsets.only(left: 10.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 250.0,
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
                ],
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
            children: [
              Text(
                repo!.description,
                style: const TextStyle(
                  color: Colors.white60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Wrap(
                  spacing: 3.0,
                  runSpacing: 1.0,
                  children: [for (String topic in topics) topicItem(topic)],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(
                      Icons.star_border,
                      color: Colors.white60,
                      size: 16.0,
                    ),
                    const Text(
                      '4.5k',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 18.0,
                    ),
                    Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      margin: const EdgeInsets.only(right: 5.0),
                    ),
                    const Text(
                      'JavaScript',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 11.0,
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    const Text(
                      'MIT license',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const Text(
                      'Updated on 9 Aug 2019',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 11.0,
                      ),
                    ),
                    const SizedBox(
                      width: 18.0,
                    ),
                    const Text(
                      '1 issue needs help ',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 11.0,
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
