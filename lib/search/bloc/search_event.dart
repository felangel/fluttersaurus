part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {
  const SearchEvent();
}

class SearchTermChanged extends SearchEvent {
  const SearchTermChanged(this.term);
  final String term;
}
