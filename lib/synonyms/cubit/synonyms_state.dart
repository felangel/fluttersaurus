part of 'synonyms_cubit.dart';

enum SynonymsStatus { loading, success, failure }

class SynonymsState extends Equatable {
  const SynonymsState._({
    this.status = SynonymsStatus.loading,
    this.synonyms = const <Synonym>[],
    this.word,
  });

  const SynonymsState.loading({String? word}) : this._(word: word);

  const SynonymsState.success({
    required String word,
    required List<Synonym> synonyms,
  }) : this._(word: word, status: SynonymsStatus.success, synonyms: synonyms);

  const SynonymsState.failure() : this._(status: SynonymsStatus.failure);

  final SynonymsStatus status;
  final List<Synonym> synonyms;
  final String? word;

  @override
  List<Object?> get props => [status, synonyms, word];
}
