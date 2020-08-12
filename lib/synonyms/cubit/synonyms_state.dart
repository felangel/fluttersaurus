part of 'synonyms_cubit.dart';

enum SynonymsStatus { loading, success, failure }

class SynonymsState extends Equatable {
  const SynonymsState._({
    this.status = SynonymsStatus.loading,
    this.synonyms = const <Synonym>[],
  });

  const SynonymsState.loading() : this._();

  const SynonymsState.success(List<Synonym> synonyms)
      : this._(status: SynonymsStatus.success, synonyms: synonyms);

  const SynonymsState.failure() : this._(status: SynonymsStatus.failure);

  final SynonymsStatus status;
  final List<Synonym> synonyms;

  @override
  List<Object> get props => [status, synonyms];
}
