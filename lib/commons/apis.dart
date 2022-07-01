import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/user.dart';

class Apis {
  final Client _client = Client();

  final Map<String, String> _headers = {
    HttpHeaders.acceptHeader: 'Accept: application/vnd.github.v3+json',
  };

  Future<Response> query({String? path, Map<String, dynamic>? params}) {
    var url = 'api.github.com';
    var response = _client.get(
      Uri.https(url, path ?? '', params),
      headers: _headers,
    );

    return response;
  }

  void queryUser(User user) async {
    var response = await query(
      path: '/users/${user.username}',
    );
    Map<String, dynamic> res = jsonDecode(utf8.decode(response.bodyBytes));
    if (res.containsKey('message')) {
      /*
      {message: Not Found, documentation_url: https://docs.github.com/rest/reference/users#get-a-user} 
      */
      debugPrint(res['message']);
      return;
    }
    /*
     {login: bodii, id: 17775161, node_id: MDQ6VXNlcjE3Nzc1MTYx, avatar_url: https://avatars.githubusercontent.com/u/17775161?v=4, gravatar_id: , url: https://api.github.com/users/bodii, html_url: https://github.com/bodii, followers_url: https://api.github.com/users/bodii/followers, following_url: https://api.github.com/users/bodii/following{/other_user}, gists_url: https://api.github.com/users/bodii/gists{/gist_id}, starred_url: https://api.github.com/users/bodii/starred{/owner}{/repo}, subscriptions_url: https://api.github.com/users/bodii/subscriptions, organizations_url: https://api.github.com/users/bodii/orgs, repos_url: https://api.github.com/users/bodii/repos, events_url: https://api.github.com/users/bodii/events{/privacy}, received_events_url: https://api.github.com/users/bodii/received_events, type: User, site_admin: false, name: null, company: null, blog: , location: null, email: null, hireable: null, bio: null, twitter_username: null, public_repos: 1, public_gists: 0, followers: 5, following: 27, created_at: 2016-03-11T02:12:59Z, updated_at: 2022-03-22T09:56:55Z}
    */

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
}
