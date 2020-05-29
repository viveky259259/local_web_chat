import 'dart:async';
import 'dart:io';

import 'package:hasura_connect/hasura_connect.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final webApiUrl = "https://web.getsync.app/api/v2";

  HasuraConnect hasuraConnect = HasuraConnect(
    'https://dogtown-hasura.herokuapp.com/v1/graphql',
  );

  Future<dynamic> query(query, {variables}) async {
    hasuraConnect.addHeader(
        'x-hasura-admin-secret', 'seVsvtXgn3n8MZKLF2jIDTdYmZkqP7Fj');
    variables = variables != null ? variables : <String, dynamic>{};
    var result = {};
    try {
      result = await hasuraConnect.query(query, variables: variables);
    } on HasuraError catch (_) {
      print("Hasura query error: ${_.toString()}");
    }
    return result['data'];
  }

  Future<dynamic> mutation(query, variables) async {
    hasuraConnect.addHeader(
        'x-hasura-admin-secret', 'seVsvtXgn3n8MZKLF2jIDTdYmZkqP7Fj');
    variables = variables != null ? variables : <String, dynamic>{};
    var result = {};
    try {
      result = await hasuraConnect.mutation(query, variables: variables);
    } on HasuraError catch (_) {
      print("Hasura mutation error: ${_.toString()}");
    }
    return result['data'];
  }

  Stream<dynamic> subscribe(query, variables, key) {
    hasuraConnect.addHeader(
        'x-hasura-admin-secret', 'seVsvtXgn3n8MZKLF2jIDTdYmZkqP7Fj');
    variables = variables != null ? variables : <String, dynamic>{};

    try {
      Snapshot snapshot =
          hasuraConnect.subscription(query, variables: variables, key: key);
      return snapshot.map((result) {
        return result['data'];
      });
    } catch (_) {
      print("Hasura subscription error: ${_.toString()}");
      return null;
    }
  }

  Future<dynamic> webApiPost(url, data) async {
    return await http.post(url, body: data, headers: {
      HttpHeaders.authorizationHeader:
          "Basic VFJJQkVTOmRyb3B2b3dlbDY2MDc1aGFzY2VudHVyeW1pbmQzMjIw"
    });
  }
}
