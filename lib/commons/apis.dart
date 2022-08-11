import 'dart:io';
import 'dart:convert';

import 'package:custom_simple_github_app/models/repo.dart';
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
  Future<List<Repo>> querySearchRepoContext(String repoName,
      {String page = '1', String perPage = '10'}) async {
    var path = 'search/repositories';
    var params = {
      'q': repoName,
      'sort': 'stars',
      'order': 'desc',
      'per_page': perPage,
      'page': page,
    };

    Response response = await query(
      path: path,
      params: params,
    );

    if (response.statusCode != HttpStatus.ok) {
      return [];
    }

    Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));

    List<dynamic> items = json['items'];

    List<Repo> repoList = [];
    for (var element in items) {
      if (element != null) {
        repoList.add(Repo.fromJson(element as Map<String, dynamic>));
      }
    }

    return repoList;
  }
}
