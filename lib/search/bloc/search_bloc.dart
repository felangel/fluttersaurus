import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fluttersaurus/search/models/suggestion.dart';
import 'package:meta/meta.dart';
import 'package:thesaurus_repository/thesaurus_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._thesaurusRepository)
      : assert(_thesaurusRepository != null),
        super(const SearchState.loading());

  final ThesaurusRepository _thesaurusRepository;

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchTermChanged) {
      yield* _mapSearchTermChangedToState(event);
    }
  }

  Stream<SearchState> _mapSearchTermChangedToState(
    SearchTermChanged event,
  ) async* {
    yield const SearchState.loading();
    try {
      final results = await _thesaurusRepository.search(term: event.term);
      final suggestions = results.map((result) => Suggestion(result)).toList();
      yield SearchState.success(suggestions);
    } on Exception {
      yield const SearchState.failure();
    }
  }
}
