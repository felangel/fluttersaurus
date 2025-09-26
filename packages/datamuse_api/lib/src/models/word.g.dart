// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter, require_trailing_commas, cast_nullable_to_non_nullable, lines_longer_than_80_chars

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Word',
  json,
  ($checkedConvert) {
    final val = Word(
      $checkedConvert('word', (v) => v as String),
      $checkedConvert('score', (v) => v as int),
      $checkedConvert(
        'tags',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      $enumDecode(_$TagEnumMap, e, unknownValue: Tag.unknown),
                )
                .toList() ??
            [],
      ),
    );
    return val;
  },
);

const _$TagEnumMap = {
  Tag.synonym: 'syn',
  Tag.noun: 'n',
  Tag.verb: 'v',
  Tag.adjective: 'adj',
  Tag.adverb: 'adv',
  Tag.properNoun: 'prop',
  Tag.antonym: 'ant',
  Tag.unknown: 'u',
};
