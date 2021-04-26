import 'package:datamuse_api/datamuse_api.dart';

/// {@template thesaurus_exception}
/// Generic exception thrown by the [ThesaurusRepository].
/// {@endtemplate}
class ThesaurusException implements Exception {
  /// {@macro thesaurus_exception}
  const ThesaurusException(this.exception, {required this.stackTrace});

  /// The exception that occured.
  final dynamic exception;

  /// The [StackTrace] for the exception.
  final StackTrace stackTrace;
}

/// {@template search_http_request_failure}
/// Thrown when an error occurs while performing a search.
/// {@endtemplate}
class SearchHttpRequestFailure extends ThesaurusException {
  /// {@macro search_http_request_failure}
  SearchHttpRequestFailure(HttpRequestFailure failure, StackTrace stackTrace)
      : super(failure, stackTrace: stackTrace);
}

/// {@template synonyms_exception}
/// Thrown when an error occurs while looking up synonyms.
/// {@endtemplate}
class SynonymsException extends ThesaurusException {
  /// {@macro synonyms_exception}
  SynonymsException(
    dynamic exception, {
    required StackTrace stackTrace,
  }) : super(exception, stackTrace: stackTrace);
}

/// {@template thesaurus_repository}
/// A Dart class which exposes methods to implement thesaurus functionality.
/// {@endtemplate}
class ThesaurusRepository {
  /// {@macro thesaurus_repository}
  ThesaurusRepository({DatamuseApiClient? datamuseApiClient})
      : _datamuseApiClient = datamuseApiClient ?? DatamuseApiClient();

  final DatamuseApiClient _datamuseApiClient;

  /// Returns a list of suggestions for the provided [term].
  /// A [limit] can optionally be provided to control the number of suggestions.
  ///
  /// Throws a [SearchHttpRequestFailure] if an error occurs.
  Future<List<String>> search({required String term, int? limit}) async {
    assert(term.isNotEmpty);
    try {
      final words = await _datamuseApiClient.suggestions(term, max: limit);
      return words.map((word) => word.word).toList();
    } on HttpRequestFailure catch (e, stackTrace) {
      throw SearchHttpRequestFailure(e, stackTrace);
    }
  }

  /// Returns a list of synonyms for the given [word].
  /// A [limit] can optionally be provided to control the number of results.
  ///
  /// Throws a [SynonymsException] if an error occurs.
  Future<List<String>> synonyms({required String word, int? limit}) async {
    assert(word.isNotEmpty);
    List<Word> words;
    try {
      words = await _datamuseApiClient.words(meansLike: word, max: limit);
    } on Exception catch (error, stackTrace) {
      throw SynonymsException(error, stackTrace: stackTrace);
    }

    return words
        .where((word) => word.tags.contains(Tag.synonym))
        .map((word) => word.word)
        .toList();
  }
}
