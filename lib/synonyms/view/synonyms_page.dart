import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersaurus/synonyms/synonyms.dart';
import 'package:thesaurus_repository/thesaurus_repository.dart';

class SynonymsPage extends StatelessWidget {
  const SynonymsPage._({Key? key}) : super(key: key);

  static Route route({required String word}) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (context) => SynonymsCubit(
          context.read<ThesaurusRepository>(),
        )..getSynonyms(word: word),
        child: const SynonymsPage._(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SynonymsView(),
    );
  }
}
