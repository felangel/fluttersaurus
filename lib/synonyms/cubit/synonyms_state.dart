part of 'synonyms_cubit.dart';

enum SynonymsStatus { loading, success, failure }

@immutable
class SynonymsState {
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

  SynonymsState copyWith({SynonymsStatus status, List<Synonym> synonyms}) {
    return SynonymsState._(
      status: status ?? this.status,
      synonyms: synonyms ?? this.synonyms,
    );
  }
}
