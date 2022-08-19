import 'package:custom_simple_github_app/models/repo.dart';

class Repos {
  late int totalCount;
  late bool incompleteResults;
  late List<Repo> items;

  Repos();

  factory Repos.fromJson(Map<String, dynamic> json) {
    Repos repos = Repos();
    repos.totalCount = json["total_count"] as int;
    repos.incompleteResults = json["incomplete_results"] as bool;

    List<dynamic> items = json['items'];
    List<Repo> repoList = [];
    for (var element in items) {
      if (element != null) {
        repoList.add(Repo.fromJson(element as Map<String, dynamic>));
      }
    }
    repos.items = repoList;

    return repos;
  }

  Map<String, dynamic> toJson() {
    return {
      'total_count': totalCount,
      'incomplete_results': incompleteResults,
      'items': [for (Repo repo in items) repo.toJson()],
    };
  }
}
