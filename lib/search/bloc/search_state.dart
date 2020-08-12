part of 'search_bloc.dart';

enum SearchStatus { loading, success, failure }

@immutable
class SearchState {
  const SearchState._({
    this.status = SearchStatus.loading,
    this.suggestions = const <Suggestion>[],
  });

  const SearchState.loading() : this._();

  const SearchState.success(List<Suggestion> suggestions)
      : this._(status: SearchStatus.success, suggestions: suggestions);

  const SearchState.failure() : this._(status: SearchStatus.failure);

  final SearchStatus status;
  final List<Suggestion> suggestions;
}
