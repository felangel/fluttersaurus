import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttersaurus/search/models/suggestion.dart';
import 'package:fluttersaurus/search/search.dart';
import 'package:rxdart/rxdart.dart';
import 'package:thesaurus_repository/thesaurus_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

EventTransformer<E> _debounce<E>() {
  return (events, mapper) {
    return events
        .debounceTime(const Duration(milliseconds: 350))
        .switchMap(mapper);
  };
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._thesaurusRepository) : super(const SearchState.initial()) {
    on<SearchTermChanged>(_onSearchTermChanged, transformer: _debounce());
  }

  final ThesaurusRepository _thesaurusRepository;

  Future<void> _onSearchTermChanged(
    SearchTermChanged event,
    Emitter<SearchState> emit,
  ) async {
    if (event.term.isEmpty) return emit(const SearchState.initial());

    if (state.status != SearchStatus.success) emit(const SearchState.loading());

    try {
      final results = await _thesaurusRepository.search(term: event.term);
      final suggestions = results.map((result) => Suggestion(result)).toList();
      emit(SearchState.success(suggestions));
    } catch (_) {
      emit(const SearchState.failure());
    }
  }
}
