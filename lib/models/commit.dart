class Commit {
  late Map<String, dynamic> author;
  late Map<String, dynamic>? committer;
  late String message;
  late Map<String, dynamic> tree;
  late String url;
  late int commentCount;
  late Map<String, dynamic> verification;

  Commit();

  factory Commit.fromJson(Map<String, dynamic> json) => Commit()
    ..author = json['author'] as Map<String, dynamic>
    ..committer = json['commiter']
    ..message = json['message'] as String
    ..tree = json['tree'] as Map<String, dynamic>
    ..url = json['url'] as String
    ..commentCount = json['comment_count'] as int
    ..verification = json['verification'] as Map<String, dynamic>;

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'commiter': committer,
      'message': message,
      'tree': tree,
      'url': url,
      'comment_count': commentCount,
      'verification': verification,
    };
  }
}
