import 'package:custom_simple_github_app/models/owner.dart';

class Repo {
  late int id;
  late String nodeId;
  late String name;
  late String fullName;
  late bool private;
  late Owner owner;
  late String htmlUrl;
  late String? description;
  late bool fork;
  late String url;
  late String forksUrl;
  late String keysUrl;
  late String collaboratorsUrl;
  late String teamsUrl;
  late String hooksUrl;
  late String issueEventsUrl;
  late String eventsUrl;
  late String assigneesUrl;
  late String branchesUrl;
  late String tagsUrl;
  late String blobsUrl;
  late String gitTagsUrl;
  late String gitRefsUrl;
  late String treesUrl;
  late String statusesUrl;
  late String languagesUrl;
  late String stargazersUrl;
  late String contributorsUrl;
  late String subscribersUrl;
  late String subscriptionUrl;
  late String commitsUrl;
  late String gitCommitsUrl;
  late String commentsUrl;
  late String issueCommentUrl;
  late String contentsUrl;
  late String compareUrl;
  late String mergesUrl;
  late String archiveUrl;
  late String downloadsUrl;
  late String issuesUrl;
  late String pullsUrl;
  late String milestonesUrl;
  late String notificationsUrl;
  late String labelsUrl;
  late String releasesUrl;
  late String deploymentsUrl;
  late String createdAt;
  late String updatedAt;
  late String? pushedAt;
  late String gitUrl;
  late String sshUrl;
  late String cloneUrl;
  late String svnUrl;
  late String? homepage;
  late int size;
  late int stargazersCount;
  late int watchersCount;
  late dynamic language;
  late bool hasIssues;
  late bool hasProjects;
  late bool hasDownloads;
  late bool hasWiki;
  late bool hasPages;
  late int forksCount;
  late String? mirrorUrl;
  late bool archived;
  late bool disabled;
  late int openIssuesCount;
  late Map<String, dynamic>? license;
  late bool allowForking;
  late bool isTemplate;
  late bool webCommitSignoffRequired;
  late List<dynamic> topics;
  late String visibility;
  late int forks;
  late int openIssues;
  late int watchers;
  late String defaultBranch;
  late double score;

  Repo();

  factory Repo.fromJson(Map<String, dynamic> json) => Repo()
    ..id = json["id"] as int
    ..nodeId = json["node_id"] as String
    ..name = json["name"] as String
    ..fullName = json["full_name"] as String
    ..private = json["private"] as bool
    ..owner = Owner.fromJson(json["owner"])
    ..htmlUrl = json["html_url"] as String
    ..description = json["description"]
    ..fork = json["fork"] as bool
    ..url = json["url"] as String
    ..forksUrl = json["forks_url"] as String
    ..keysUrl = json["keys_url"] as String
    ..collaboratorsUrl = json["collaborators_url"] as String
    ..teamsUrl = json["teams_url"] as String
    ..hooksUrl = json["hooks_url"] as String
    ..issueEventsUrl = json["issue_events_url"] as String
    ..eventsUrl = json["events_url"] as String
    ..assigneesUrl = json["assignees_url"] as String
    ..branchesUrl = json["branches_url"] as String
    ..tagsUrl = json["tags_url"] as String
    ..blobsUrl = json["blobs_url"] as String
    ..gitTagsUrl = json["git_tags_url"] as String
    ..gitRefsUrl = json["git_refs_url"] as String
    ..treesUrl = json["trees_url"] as String
    ..statusesUrl = json["statuses_url"] as String
    ..languagesUrl = json["languages_url"] as String
    ..stargazersUrl = json["stargazers_url"] as String
    ..contributorsUrl = json["contributors_url"] as String
    ..subscribersUrl = json["subscribers_url"] as String
    ..subscriptionUrl = json["subscription_url"] as String
    ..commitsUrl = json["commits_url"] as String
    ..gitCommitsUrl = json["git_commits_url"] as String
    ..commentsUrl = json["comments_url"] as String
    ..issueCommentUrl = json["issue_comment_url"] as String
    ..contentsUrl = json["contents_url"] as String
    ..compareUrl = json["compare_url"] as String
    ..mergesUrl = json["merges_url"] as String
    ..archiveUrl = json["archive_url"] as String
    ..downloadsUrl = json["downloads_url"] as String
    ..issuesUrl = json["issues_url"] as String
    ..pullsUrl = json["pulls_url"] as String
    ..milestonesUrl = json["milestones_url"] as String
    ..notificationsUrl = json["notifications_url"] as String
    ..labelsUrl = json["labels_url"] as String
    ..releasesUrl = json["releases_url"] as String
    ..deploymentsUrl = json["deployments_url"] as String
    ..createdAt = json["created_at"] as String
    ..updatedAt = json["updated_at"] as String
    ..pushedAt = json["pushed_at"]
    ..gitUrl = json["git_url"] as String
    ..sshUrl = json["ssh_url"] as String
    ..cloneUrl = json["clone_url"] as String
    ..svnUrl = json["svn_url"] as String
    ..homepage = json["homepage"]
    ..size = json["size"] as int
    ..stargazersCount = json["stargazers_count"] as int
    ..watchersCount = json["watchers_count"] as int
    ..language = json["language"]
    ..hasIssues = json["has_issues"] as bool
    ..hasProjects = json["has_projects"] as bool
    ..hasDownloads = json["has_downloads"] as bool
    ..hasWiki = json["has_wiki"] as bool
    ..hasPages = json["has_pages"] as bool
    ..forksCount = json["forks_count"] as int
    ..mirrorUrl = json["mirror_url"]
    ..archived = json["archived"] as bool
    ..disabled = json["disabled"] as bool
    ..openIssuesCount = json["open_issues_count"] as int
    ..license = json["license"]
    ..allowForking = json["allow_forking"] as bool
    ..isTemplate = json["is_template"] as bool
    ..webCommitSignoffRequired = json["web_commit_signoff_required"] as bool
    ..topics = json["topics"]
    ..visibility = json["visibility"] as String
    ..forks = json["forks"] as int
    ..openIssues = json["open_issues"] as int
    ..watchers = json["watchers"] as int
    ..defaultBranch = json["default_branch"] as String
    ..score = json["score"] as double;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'node_id': nodeId,
      'name': name,
      'full_name': fullName,
      'private': private,
      'owner': owner,
      'html_url': htmlUrl,
      'description': description,
      'fork': fork,
      'url': url,
      'forks_url': forksUrl,
      'keys_url': keysUrl,
      'collaborators_url': collaboratorsUrl,
      'teams_url': teamsUrl,
      'hooks_url': hooksUrl,
      'issue_events_url': issueEventsUrl,
      'events_url': eventsUrl,
      'assignees_url': assigneesUrl,
      'branches_url': branchesUrl,
      'tags_url': tagsUrl,
      'blobs_url': blobsUrl,
      'git_tags_url': gitTagsUrl,
      'git_refs_url': gitRefsUrl,
      'trees_url': treesUrl,
      'statuses_url': statusesUrl,
      'languages_url': languagesUrl,
      'stargazers_url': stargazersUrl,
      'contributors_url': contributorsUrl,
      'subscribers_url': subscribersUrl,
      'subscription_url': subscriptionUrl,
      'commits_url': commitsUrl,
      'git_commits_url': gitCommitsUrl,
      'comments_url': commentsUrl,
      'issue_comment_url': issueCommentUrl,
      'contents_url': contentsUrl,
      'compare_url': compareUrl,
      'merges_url': mergesUrl,
      'archive_url': archiveUrl,
      'downloads_url': downloadsUrl,
      'issues_url': issuesUrl,
      'pulls_url': pullsUrl,
      'milestones_url': milestonesUrl,
      'notifications_url': notificationsUrl,
      'labels_url': labelsUrl,
      'releases_url': releasesUrl,
      'deployments_url': deploymentsUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'pushed_at': pushedAt,
      'git_url': gitUrl,
      'ssh_url': sshUrl,
      'clone_url': cloneUrl,
      'svn_url': svnUrl,
      'homepage': homepage,
      'size': size,
      'stargazers_count': stargazersCount,
      'watchers_count': watchersCount,
      'language': language,
      'has_issues': hasIssues,
      'has_projects': hasProjects,
      'has_downloads': hasDownloads,
      'has_wiki': hasWiki,
      'has_pages': hasPages,
      'forks_count': forksCount,
      'mirror_url': mirrorUrl,
      'archived': archived,
      'disabled': disabled,
      'open_issues_count': openIssuesCount,
      'license': license,
      'allow_forking': allowForking,
      'is_template': isTemplate,
      'web_commit_signoff_required': webCommitSignoffRequired,
      'topics': topics,
      'visibility': visibility,
      'forks': forks,
      'open_issues': openIssues,
      'watchers': watchers,
      'default_branch': defaultBranch,
      'score': score,
    };
  }
}
