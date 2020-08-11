import 'package:json_annotation/json_annotation.dart';

part 'word.g.dart';

/// {@template word}
/// Word returned by the Datamuse API.
/// Each [Word] contains the [word] itself as well as a [score].
/// {@endtemplate}
@JsonSerializable(nullable: false, createToJson: false)
class Word {
  /// {@macro word}
  const Word(this.word, this.score);

  /// Converts a [Map<String, dynamic>] into a [Word] instance.
  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  /// The word itself.
  final String word;

  /// The score -- higher means closer match.
  final int score;
}
