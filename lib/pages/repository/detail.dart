import 'package:custom_simple_github_app/commons/apis.dart';
import 'package:custom_simple_github_app/commons/functions.dart';
import 'package:custom_simple_github_app/models/commit_info.dart';
import 'package:custom_simple_github_app/models/content.dart';
import 'package:custom_simple_github_app/models/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RepoitoryDetailView extends StatefulWidget {
  const RepoitoryDetailView({Key? key}) : super(key: key);

  @override
  State<RepoitoryDetailView> createState() => _RepoitoryDetailViewState();
}

class _RepoitoryDetailViewState extends State<RepoitoryDetailView> {
  late Repo repo;
  List<CommitInfo> commitList = [];
  List<Content> contentList = [];

  @override
  void initState() {
    super.initState();
    repo = Get.arguments['info'];
    getCommitList();
  }

  void getCommitList() async {
    Apis apis = Apis();
    commitList = await apis.getCommitList(repo.fullName);
    contentList = await apis.getContents(repo.fullName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(repo.fullName)),
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
                const Icon(
                  Icons.book,
                  color: Colors.white54,
                  size: 18.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 235.0,
                      minWidth: 50.0,
                    ),
                    child: Text(
                      repo.fullName,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Container(
                  width: 35.0,
                  height: 17.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.white60, width: .6),
                  ),
                  child: Text(
                    repo.visibility,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 8.0,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade900,
                        padding: const EdgeInsets.all(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      ),
                      onPressed: () {},
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade900,
                        padding: const EdgeInsets.all(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(
                              Icons.notifications,
                              color: Colors.grey,
                              size: 18.0,
                            ),
                            Text(
                              'Notifications',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 11.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade900,
                        padding: const EdgeInsets.all(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              'assets/images/fork.svg',
                              color: Colors.grey,
                              width: 16.0,
                              height: 16.0,
                            ),
                            Text(
                              'Fork ${Funcs.intToUnit(repo.forksCount, 1000, 'k')}',
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 11.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade900,
                        padding: const EdgeInsets.all(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.star_border,
                              color: Colors.grey,
                              size: 18.0,
                            ),
                            Text(
                              'Star ${Funcs.intToUnit(repo.watchersCount, 1000, 'k')}',
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 11.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: .1,
              color: Colors.white12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 90.0,
                    height: 30.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade900,
                        padding: const EdgeInsets.all(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              'assets/images/branch.svg',
                              color: Colors.grey,
                            ),
                            Text(
                              repo.defaultBranch,
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 13.0,
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              size: 12.0,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: SizedBox(
                          width: 80.0,
                          height: 30.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey.shade900,
                              padding: const EdgeInsets.all(0),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Go to file',
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 75.0,
                        height: 30.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green[900],
                            padding: const EdgeInsets.all(0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  'Code',
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 13.0,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 12.0,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 400.0,
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey, width: .6),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 25.0,
                        height: 25.0,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            commitList.first.author.avatarUrl,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          commitList.first.commit.author['name'],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: SizedBox(
                          width: 100.0,
                          child: Text(
                            commitList.first.commit.message,
                            style: const TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.check,
                        color: Colors.green[800],
                        size: 18.0,
                      ),
                      const Text(
                        '21 hours age',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const Icon(
                        Icons.restore,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                      // const Text(
                      //   '15,124',
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
