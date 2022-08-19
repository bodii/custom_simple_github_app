import 'package:custom_simple_github_app/models/commit.dart';
import 'package:custom_simple_github_app/models/commit_file.dart';
import 'package:custom_simple_github_app/models/owner.dart';

class CommitInfo {
  late String sha;
  late String nodeId;
  late Commit commit;
  late String url;
  late String htmlUrl;
  late String commentsUrl;
  late Owner author;
  late Map<String, dynamic> committer;
  late List<dynamic> parents;
  late Map<String, dynamic>? stats;
  late List<CommitFile>? files;

  CommitInfo();

  factory CommitInfo.fromJson(Map<String, dynamic> json) => CommitInfo()
    ..sha = json['sha'] as String
    ..nodeId = json['node_id'] as String
    ..commit = Commit.fromJson(json['commit'])
    ..url = json['url'] as String
    ..htmlUrl = json['html_url'] as String
    ..commentsUrl = json['comments_url'] as String
    ..author = Owner.fromJson(json['author'])
    ..committer = json['committer'] as Map<String, dynamic>
    ..parents = json['parents'] as List<dynamic>
    ..stats = json['stats']
    ..files = [for (var file in json['files'] ?? []) CommitFile.fromJson(file)];

  Map<String, dynamic> toJson() {
    return {
      'sha': sha,
      'node_id': nodeId,
      'commit': commit.toJson(),
      'url': url,
      'html_url': htmlUrl,
      'comments_url': commentsUrl,
      'author': author.toJson(),
      'committer': committer,
      'parents': parents,
      'stats': stats,
      'files': [for (CommitFile file in files!) file.toJson()],
    };
  }
}
