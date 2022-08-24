class Content {
  late String name;
  late String path;
  late String sha;
  late int size;
  late String url;
  late String htmlUrl;
  late String gitUrl;
  late String? downloadUrl;
  late String type;
  late String? content;
  late String? encoding;
  late Map<String, dynamic> links;

  Content();

  factory Content.fromJson(Map<String, dynamic> json) => Content()
    ..name = json['name'] as String
    ..path = json['path'] as String
    ..sha = json['sha'] as String
    ..size = json['size'] as int
    ..url = json['url'] as String
    ..htmlUrl = json['html_url'] as String
    ..gitUrl = json['git_url'] as String
    ..downloadUrl = json['download_url']
    ..type = json['type'] as String
    ..content = json['content']
    ..encoding = json['encoding']
    ..links = json['_links'] as Map<String, dynamic>;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'path': path,
      'sha': sha,
      'size': size,
      'url': url,
      'html_url': htmlUrl,
      'git_url': gitUrl,
      'download_url': downloadUrl,
      'type': type,
      'content': content,
      'encoding': encoding,
      '_links': links,
    };
  }
}
