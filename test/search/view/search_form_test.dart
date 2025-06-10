import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttersaurus/search/search.dart';
import 'package:fluttersaurus/synonyms/synonyms.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thesaurus_repository/thesaurus_repository.dart';

class MockThesaurusRepository extends Mock implements ThesaurusRepository {}

class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

void main() {
  group('SearchForm', () {
    late SearchBloc searchBloc;

    setUpAll(() {
      registerFallbackValue(const SearchTermChanged(''));
      registerFallbackValue(const SearchState.initial());
    });

    setUp(() {
      searchBloc = MockSearchBloc();
      when(() => searchBloc.state).thenReturn(const SearchState.initial());
    });

    testWidgets('adds SearchTermChanged when text is entered', (tester) async {
      const term = 'cats';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: searchBloc,
              child: const SearchForm(),
            ),
          ),
        ),
      );

      await tester.enterText(
        find.byKey(const Key('searchBar_textField')),
        term,
      );

      verify(() => searchBloc.add(const SearchTermChanged(term))).called(1);
    });

    testWidgets('renders initial text when state is initial', (tester) async {
      when(() => searchBloc.state).thenReturn(const SearchState.initial());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: searchBloc,
              child: const SearchForm(),
            ),
          ),
        ),
      );
      expect(find.byKey(const Key('search_initial_text')), findsOneWidget);
    });

    testWidgets('renders loading shimmer when state is loading', (
      tester,
    ) async {
      when(() => searchBloc.state).thenReturn(const SearchState.loading());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: searchBloc,
              child: const SearchForm(),
            ),
          ),
        ),
      );
      expect(find.byKey(const Key('search_loading_shimmer')), findsOneWidget);
    });

    testWidgets('renders SearchResults when state is success', (tester) async {
      when(() => searchBloc.state).thenReturn(const SearchState.success([]));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: searchBloc,
              child: const SearchForm(),
            ),
          ),
        ),
      );
      expect(find.byType(SearchResults), findsOneWidget);
    });

    testWidgets('renders SnackBar when state is failure', (tester) async {
      when(() => searchBloc.state).thenReturn(const SearchState.failure());
      whenListen(
        searchBloc,
        Stream.fromIterable(
          const <SearchState>[SearchState.loading(), SearchState.failure()],
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: searchBloc,
              child: const SearchForm(),
            ),
          ),
        ),
      );

      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('navigates to SynonymsPage when suggestion is tapped', (
      tester,
    ) async {
      const word = 'kitty';
      final thesaurusRepository = MockThesaurusRepository();
      when(
        () => thesaurusRepository.synonyms(word: any(named: 'word')),
      ).thenAnswer((_) async => []);
      when(() => searchBloc.state).thenReturn(
        const SearchState.success([Suggestion(word)]),
      );
      await tester.pumpWidget(
        RepositoryProvider<ThesaurusRepository>.value(
          value: thesaurusRepository,
          child: MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: searchBloc,
                child: const SearchForm(),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text(word));
      await tester.pumpAndSettle();
      expect(find.byType(SynonymsPage), findsOneWidget);
    });
  });
}
