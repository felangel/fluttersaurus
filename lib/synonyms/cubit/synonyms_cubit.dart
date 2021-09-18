import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttersaurus/synonyms/synonyms.dart';
import 'package:thesaurus_repository/thesaurus_repository.dart';

part 'synonyms_state.dart';

class SynonymsCubit extends Cubit<SynonymsState> {
  SynonymsCubit(this._thesaurusRepository)
      : super(const SynonymsState.loading());

  final ThesaurusRepository _thesaurusRepository;

  Future<void> getSynonyms({required String word}) async {
    emit(SynonymsState.loading(word: word));
    try {
      final results = await _thesaurusRepository.synonyms(word: word);
      final synonyms = results.map((result) => Synonym(result)).toList();
      emit(SynonymsState.success(word: word, synonyms: synonyms));
    } on Exception {
      emit(const SynonymsState.failure());
    }
  }
}
