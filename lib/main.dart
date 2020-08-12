import 'package:flutter/widgets.dart';
import 'package:fluttersaurus/fluttersaurus.dart';
import 'package:thesaurus_repository/thesaurus_repository.dart';

void main() {
  runApp(
    Fluttersaurus(thesaurusRepository: ThesaurusRepository()),
  );
}
