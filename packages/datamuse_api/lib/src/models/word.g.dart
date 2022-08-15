// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      json['word'] as String,
      json['score'] as int,
      (json['tags'] as List<dynamic>?)
              ?.map((e) =>
                  $enumDecode(_$TagEnumMap, e, unknownValue: Tag.unknown))
              .toList() ??
          [],
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
