import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttersaurus/search/models/suggestion.dart';
import 'package:fluttersaurus/search/search.dart';
import 'package:rxdart/rxdart.dart';
import 'package:thesaurus_repository/thesaurus_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._thesaurusRepository)
      : assert(_thesaurusRepository != null),
        super(const SearchState.initial());

  final ThesaurusRepository _thesaurusRepository;

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    Stream<SearchEvent> events,
    TransitionFunction<SearchEvent, SearchState> transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 350))
        .switchMap(transitionFn);
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchTermChanged) {
      yield* _mapSearchTermChangedToState(event, state);
    }
  }

  Stream<SearchState> _mapSearchTermChangedToState(
    SearchTermChanged event,
    SearchState state,
  ) async* {
    if (event.term.isEmpty) {
      yield const SearchState.initial();
      return;
    }

    if (state.status != SearchStatus.success) {
      yield const SearchState.loading();
    }

    try {
      final results = await _thesaurusRepository.search(term: event.term);
      final suggestions = results.map((result) => Suggestion(result)).toList();
      yield SearchState.success(suggestions);
    } on Exception {
      yield const SearchState.failure();
    }
  }
}
