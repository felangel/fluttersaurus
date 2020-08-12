import 'dart:io';

import 'package:thesaurus_repository/thesaurus_repository.dart';

void main() async {
  final thesaurusRepository = ThesaurusRepository();

  try {
    final synonyms = await thesaurusRepository.search(term: 'lun', limit: 3);
    for (final synonym in synonyms) {
      print(synonym);
    }
  } on Exception catch (e) {
    print(e);
  }

  exit(0);
}
