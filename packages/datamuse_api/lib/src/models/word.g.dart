// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) {
  return Word(
    json['word'] as String,
    json['score'] as int,
    (json['tags'] as List)
            ?.map((e) => _$enumDecodeNullable(_$TagEnumMap, e))
            ?.toList() ??
        [],
  );
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
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
