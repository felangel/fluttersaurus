part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchTermChanged extends SearchEvent {
  const SearchTermChanged(this.term);
  final String term;

  @override
  List<Object> get props => [term];
}
