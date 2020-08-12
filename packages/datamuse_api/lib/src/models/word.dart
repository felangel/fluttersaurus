import 'package:json_annotation/json_annotation.dart';

part 'word.g.dart';

/// {@template word}
/// Word returned by the Datamuse API.
/// Each [Word] contains the [word] itself as well as a [score].
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class Word {
  /// {@macro word}
  const Word(this.word, this.score, [this.tags = const <Tag>[]]);

  /// Converts a [Map<String, dynamic>] into a [Word] instance.
  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  /// The word itself.
  final String word;

  /// The score -- higher means closer match.
  final int score;

  /// One or more part-of-speech codes.
  @JsonKey(defaultValue: <Tag>[])
  final List<Tag> tags;
}

/// Part-of-speech codes which are associated with words.
enum Tag {
  /// Synonym
  @JsonValue('syn')
  synonym,

  /// Noun
  @JsonValue('n')
  noun,

  /// Verb
  @JsonValue('v')
  verb,

  /// Adjective
  @JsonValue('adj')
  adjective,

  /// Adverb
  @JsonValue('adv')
  adverb,

  /// Proper Noun
  @JsonValue('prop')
  properNoun,

  /// Antonym
  @JsonValue('ant')
  antonym,

  /// Unknown
  @JsonValue('u')
  unknown,
}
