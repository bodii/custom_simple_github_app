class CommitFile {
  late String sha;
  late String filename;
  late String status;
  late int additions;
  late int deletions;
  late int changes;
  late String blobUrl;
  late String rawUrl;
  late String contentsUrl;
  late String patch;

  CommitFile();

  factory CommitFile.fromJson(Map<String, dynamic> json) => CommitFile()
    ..sha = json['sha']
    ..filename = json['filename']
    ..status = json['status']
    ..additions = json['additions'] as int
    ..deletions = json['deletions'] as int
    ..changes = json['changes'] as int
    ..blobUrl = json['blob_url']
    ..rawUrl = json['raw_url']
    ..contentsUrl = json['contents_url']
    ..patch = json['patch'];

  Map<String, dynamic> toJson() {
    return {
      'sha': sha,
      'filename': filename,
      'status': status,
      'additions': additions,
      'deletions': deletions,
      'changes': changes,
      'blob_url': blobUrl,
      'raw_url': rawUrl,
      'contents_url': contentsUrl,
      'patch': patch,
    };
  }
}
