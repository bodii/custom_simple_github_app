import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RepositorySearchListView extends StatelessWidget {
  const RepositorySearchListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> topics = [
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
                    onPressed: () {},
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
            RepoItem(),
          ],
        ),
      ),
    );
  }
}

class RepoItem extends StatelessWidget {
  RepoItem({
    Key? key,
  }) : super(key: key);

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
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Demon799/fdsfsdfdsfsdfF',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16.0,
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
                width: 60.0,
                height: 18.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.white60, width: .6),
                ),
                child: const Text(
                  'Public archive',
                  style: TextStyle(
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
              const Text(
                'Simple but Powerful web-based Control Panel',
                style: TextStyle(
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
                padding: const EdgeInsets.only(top: 8.0),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(
                      Icons.star_border,
                      color: Colors.white60,
                      size: 18.0,
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
