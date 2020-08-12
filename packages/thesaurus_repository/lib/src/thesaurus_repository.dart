import 'package:datamuse_api/datamuse_api.dart';
import 'package:meta/meta.dart';

/// Thrown when an error occurs while performing a search.
class SearchException implements Exception {}

/// Thrown when an error occurs while looking up synonyms.
class SynonymsException implements Exception {}

/// {@template thesaurus_repository}
/// A Dart class which exposes methods to implement thesaurus functionality.
/// {@endtemplate}
class ThesaurusRepository {
  /// {@macro thesaurus_repository}
  ThesaurusRepository({DatamuseApiClient datamuseApiClient})
      : _datamuseApiClient = datamuseApiClient ?? DatamuseApiClient();

  final DatamuseApiClient _datamuseApiClient;

  /// Returns a list of suggestions for the provided [term].
  /// A [limit] can optionally be provided to control the number of suggestions.
  ///
  /// Throws a [SearchException] if an error occurs.
  Future<List<String>> search({@required String term, int limit}) async {
    assert(term != null && term.isNotEmpty);
    try {
      final words = await _datamuseApiClient.suggestions(term, max: limit);
      return words.map((word) => word.word).toList();
    } on Exception {
      throw SearchException();
    }
  }

  /// Returns a list of synonyms for the given [word].
  /// A [limit] can optionally be provided to control the number of results.
  ///
  /// Throws a [SynonymsException] if an error occurs.
  Future<List<String>> synonyms({@required String word, int limit}) async {
    assert(word != null && word.isNotEmpty);
    List<Word> words;
    try {
      words = await _datamuseApiClient.words(meansLike: word, max: limit);
    } on Exception {
      throw SynonymsException();
    }

    return words
        .where((word) => word.tags.contains(Tag.synonym))
        .map((word) => word.word)
        .toList();
  }
}
