class Owner {
  late String? login;
  late int id;
  late String nodeId;
  late String avatarUrl;
  late String gravatarId;
  late String url;
  late String htmlUrl;
  late String followersUrl;
  late String followingUrl;
  late String gistsUrl;
  late String starredUrl;
  late String subscriptionsUrl;
  late String organizationsUrl;
  late String reposUrl;
  late String eventsUrl;
  late String receivedEventsUrl;
  late String type;
  late bool siteAdmin;

  Owner();

  factory Owner.fromJson(Map<String, dynamic> json) => Owner()
    ..login = json['login']
    ..id = json['id'] as int
    ..nodeId = json['node_id'] as String
    ..avatarUrl = json['avatar_url'] as String
    ..gravatarId = json['gravatar_id'] as String
    ..url = json['url'] as String
    ..htmlUrl = json['html_url'] as String
    ..followersUrl = json['followers_url'] as String
    ..followingUrl = json['following_url'] as String
    ..gistsUrl = json['gists_url'] as String
    ..starredUrl = json['starred_url'] as String
    ..subscriptionsUrl = json['subscriptions_url'] as String
    ..organizationsUrl = json['organizations_url'] as String
    ..reposUrl = json['repos_url'] as String
    ..eventsUrl = json['events_url'] as String
    ..receivedEventsUrl = json['received_events_url'] as String
    ..type = json['type'] as String
    ..siteAdmin = json['site_admin'] as bool;

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'id': id,
      'node_id': nodeId,
      'avatar_url': avatarUrl,
      'gravatar_id': gravatarId,
      'url': url,
      'html_url': htmlUrl,
      'followers_url': followersUrl,
      'following_url': followingUrl,
      'gists_url': gistsUrl,
      'starred_url': starredUrl,
      'subscriptions_url': subscriptionsUrl,
      'organizations_url': organizationsUrl,
      'repos_url': reposUrl,
      'events_url': eventsUrl,
      'received_events_url': receivedEventsUrl,
      'type': type,
      'site_admin': siteAdmin,
    };
  }
}
