import 'dart:io';
import 'dart:convert';

import 'package:custom_simple_github_app/models/commit_info.dart';
import 'package:custom_simple_github_app/models/content.dart';
import 'package:custom_simple_github_app/models/repos.dart';
import 'package:custom_simple_github_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Apis {
  final Client _client = Client();

  final Map<String, String> _headers = {
    HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
        "application/vnd.github.symmetra-preview+json",
    // HttpHeaders.authorizationHeader: "API_TOKEN"
  };

  Future<Response> query({String path = '', Map<String, dynamic>? params}) {
    var url = 'api.github.com';
    var response = _client.get(
      Uri.https(url, path, params),
      headers: _headers,
    );

    return response;
  }

  Future<Response> getUrl(String url) {
    Future<Response> response = _client.get(
      Uri.parse(url),
      headers: _headers,
    );

    return response;
  }

  Future get(String url, [String errorMsg = 'Failed to load data of']) async {
    Response response = await getUrl(url);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('$errorMsg $url');
    }

    var json = jsonDecode(utf8.decode(response.bodyBytes));

    return json;
  }

  Future<Response> post(
      {String? path,
      Map<String, String>? headers,
      Map<String, dynamic>? params}) {
    Future<Response> response = _client.post(
      Uri.https('api.github.com', path ?? '', params),
      headers: headers,
    );

    return response;
  }

  /// https://api.github.com/users/freeCodeCamp
  void queryUser(User user) async {
    var response = await query(
      path: '/users/${user.login}',
    );
    Map<String, dynamic> res = jsonDecode(utf8.decode(response.bodyBytes));
    if (res.containsKey('message')) {
      /*
      {message: Not Found, documentation_url: https://docs.github.com/rest/reference/users#get-a-user} 
      */
      debugPrint(res['message']);
      return;
    }

    debugPrint(res['login']);
  }

  void login(String username, String password) async {
    String userBasic = base64.encode(utf8.encode('$username:$password'));
    String basic = 'Basic $userBasic';
    _headers.addAll({HttpHeaders.authorizationHeader: basic});
    debugPrint(_headers.toString());
    var response = await query(path: '/users/$username');
    debugPrint(response.body);
  }

  /// https://docs.github.com/cn/rest/search
  /// https://api.github.com/search/repositories?q=react&sort=stars&order=desc
  /// https://api.github.com/repos/freeCodeCamp/freeCodeCamp
  Future<Repos> querySearchRepos(
    String repoName, {
    String page = '1',
    String perPage = '10',
    String sort = '',
    String order = 'desc',
  }) async {
    var path = 'search/repositories';
    var params = {
      'q': repoName,
      'sort': sort,
      'order': order,
      'per_page': perPage,
      'page': page,
    };

    Response response = await query(
      path: path,
      params: params,
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to load repos');
    }

    Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));

    Repos repos = Repos.fromJson(json);
    return repos;
  }

  Future<List<CommitInfo>> getCommitList(
    String repoName, {
    int page = 1,
    int perPage = 10,
    String sort = '',
    String order = 'desc',
  }) async {
    var path = 'repos/$repoName/commits';
    var params = {
      'sort': sort,
      'order': order,
      'per_page': perPage.toString(),
      'page': page.toString(),
    };

    Response response = await query(
      path: path,
      params: params,
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to load commits');
    }

    List<dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));

    List<CommitInfo> commits = [
      for (var c in json) CommitInfo.fromJson(c as Map<String, dynamic>)
    ];
    return commits;
  }

  Future<List<Content>> getContents(
    String repoName, {
    int page = 1,
    int perPage = 10,
    String sort = '',
    String order = 'desc',
  }) async {
    var path = 'repos/$repoName/contents';
    var params = {
      'sort': sort,
      'order': order,
      'per_page': perPage.toString(),
      'page': page.toString(),
    };

    Response response = await query(
      path: path,
      params: params,
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to load contents');
    }

    List<dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));

    // print(json);

    List<Content> contents = [
      for (var c in json) Content.fromJson(c as Map<String, dynamic>)
    ];
    return contents;
  }

  Future<List<Content>> getPath(String repoName, [String path = '']) async {
    var uri = 'repos/$repoName/contents/$path';
    debugPrint(uri);

    Response response = await query(
      path: uri,
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to load content');
    }

    List<dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
    List<Content> contents = [
      for (var c in json) Content.fromJson(c as Map<String, dynamic>)
    ];
    return contents;
  }

  Future<Content> getContent(
    String repoName, [
    String path = '',
    String branch = 'main',
  ]) async {
    var uri = 'repos/$repoName/contents/$path';
    debugPrint(uri);

    Response response = await query(
      path: uri,
      params: {'ref': branch},
    );

    if (response.statusCode != HttpStatus.ok) {
      debugPrint(response.statusCode.toString());
      throw Exception('Failed to load content');
    }

    Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
    return Content.fromJson(json);
  }

  Future<CommitInfo> getBranchCommit(
    String repoName,
    String branchOrTag,
  ) async {
    var path = 'repos/$repoName/commits/$branchOrTag';

    Response response = await query(
      path: path,
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to load a branch commit');
    }

    Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));

    return CommitInfo.fromJson(json);
  }
}
