import 'dart:io';

import 'package:datamuse_api/datamuse_api.dart';

void main() async {
  final datamuseApiClient = DatamuseApiClient();

  try {
    final words = await datamuseApiClient.meansLike('cats');
    for (final word in words) {
      print(word.word);
    }
  } on Exception catch (e) {
    print(e);
  }

  exit(0);
}
