// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) {
  return Word(
    json['word'] as String,
    json['score'] as int,
    (json['tags'] as List<dynamic>?)
            ?.map((e) => _$enumDecode(_$TagEnumMap, e))
            .toList() ??
        [],
  );
}

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

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
