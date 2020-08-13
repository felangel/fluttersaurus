import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersaurus/synonyms/synonyms.dart';
import 'package:thesaurus_repository/thesaurus_repository.dart';

class SynonymsPage extends StatelessWidget {
  const SynonymsPage._({Key key, @required String word})
      : assert(word != null),
        _word = word,
        super(key: key);

  static Route route({@required String word}) {
    return MaterialPageRoute<void>(
      builder: (_) => SynonymsPage._(word: word),
    );
  }

  final String _word;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => SynonymsCubit(
          context.repository<ThesaurusRepository>(),
        )..getSynonyms(word: _word),
        child: SynonymsView(word: _word),
      ),
    );
  }
}
