import 'dart:convert';

import 'package:datamuse_api/datamuse_api.dart';
import 'package:http/http.dart' as http;

/// Thrown if an exception occurs while making an `http` request.
class HttpException implements Exception {}

/// {@template http_request_failure}
/// Thrown if an `http` request returns a non-200 status code.
/// {@endtemplate}
class HttpRequestFailure implements Exception {
  /// {@macro http_request_failure}
  const HttpRequestFailure(this.statusCode);

  /// The status code of the response.
  final int statusCode;
}

/// Thrown if an excepton occurs while decoding the response body.
class JsonDecodeException implements Exception {}

/// Thrown is an error occurs while deserializing the response body.
class JsonDeserializationException implements Exception {}

/// {@template datamuse_api_client}
/// A Dart API Client for the datamuse REST API.
/// Learn more at https://www.datamuse.com/api/
/// {@endtemplate}
class DatamuseApiClient {
  /// {@macro datamuse_api_client}
  DatamuseApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _authority = 'api.datamuse.com';

  final http.Client _httpClient;

  /// Returns a list of words (and multiword expressions)
  /// from a given vocabulary that match a given set of constraints.
  Future<List<Word>> words({
    String? meansLike,
    String? soundsLike,
    String? spelledLike,
    int? max,
  }) async {
    final queryParams = <String, String>{};
    if (meansLike != null) {
      queryParams.addAll({'ml': meansLike});
    }
    if (soundsLike != null) {
      queryParams.addAll({'sl': soundsLike});
    }
    if (spelledLike != null) {
      queryParams.addAll({'sp': spelledLike});
    }
    if (max != null) {
      queryParams.addAll({'max': '$max'});
    }
    final uri = Uri.https(_authority, '/words', queryParams);
    return _fetchWords(uri);
  }

  /// Provides word suggestions given a partially-entered query.
  /// GET /sug?s=$query
  Future<List<Word>> suggestions(String query, {int? max}) async {
    final queryParams = <String, String>{'s': query};
    if (max != null) {
      queryParams.addAll({'max': '$max'});
    }
    final uri = Uri.https(_authority, '/sug', queryParams);
    return _fetchWords(uri);
  }

  Future<List<Word>> _fetchWords(Uri uri) async {
    http.Response response;

    try {
      response = await _httpClient.get(uri);
    } on Exception {
      throw HttpException();
    }

    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }

    List body;

    try {
      body = json.decode(response.body) as List;
    } on Exception {
      throw JsonDecodeException();
    }

    try {
      return body
          .map((dynamic item) => Word.fromJson(item as Map<String, dynamic>))
          .toList();
    } on Exception {
      throw JsonDeserializationException();
    }
  }
}
