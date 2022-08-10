class User {
  late String login;
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
  late String name;
  late String company;
  late String blog;
  late String location;
  late String email;
  late String hireable;
  late String bio;
  late String twitterUsername;
  late int publicRepos;
  late int publicGists;
  late int followers;
  late int following;
  late String createdAt;
  late String updatedAt;

  User();

  factory User.fromJson(Map<String, dynamic> json) => User()
    ..login = json['login'] as String
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
    ..siteAdmin = json['site_admin'] as bool
    ..name = json['name'] as String
    ..company = json['company'] as String
    ..blog = json['blog'] as String
    ..location = json['location'] as String
    ..email = json['email'] as String
    ..hireable = json['hireable'] as String
    ..bio = json['bio'] as String
    ..twitterUsername = json['twitter_username'] as String
    ..publicRepos = json['public_repos'] as int
    ..publicGists = json['public_gists'] as int
    ..followers = json['followers'] as int
    ..following = json['following'] as int
    ..createdAt = json['created_at'] as String
    ..updatedAt = json['updated_at'] as String;

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'id': id,
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
      'name': name,
      'company': company,
      'blog': blog,
      'location': location,
      'email': email,
      'hireable': hireable,
      'bio': bio,
      'twitter_username': twitterUsername,
      'public_repos': publicRepos,
      'public_gists': publicGists,
      'followers': followers,
      'following': following,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
