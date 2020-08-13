import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttersaurus/search/search.dart';
import 'package:mockito/mockito.dart';
import 'package:thesaurus_repository/thesaurus_repository.dart';

class MockThesaurusRepository extends Mock implements ThesaurusRepository {}

void main() {
  const debounceDuration = Duration(milliseconds: 350);

  group('SearchBloc', () {
    ThesaurusRepository thesaurusRepository;

    setUp(() {
      thesaurusRepository = MockThesaurusRepository();
    });

    test('throws AssertionError when thesaurusRepository is null', () {
      expect(() => SearchBloc(null), throwsAssertionError);
    });

    test('initial state is SearchState.initial', () {
      final searchBloc = SearchBloc(thesaurusRepository);
      expect(searchBloc.state, const SearchState.initial());
      searchBloc.close();
    });

    group('SearchTermChanged', () {
      const term = 'cats';

      setUp(() {
        when(thesaurusRepository.search(
          term: anyNamed('term'),
          limit: anyNamed('limit'),
        )).thenAnswer((_) async => <String>[]);
      });

      blocTest<SearchBloc, SearchState>(
        'invokes search on thesaurusRepository',
        build: () => SearchBloc(thesaurusRepository),
        act: (bloc) => bloc.add(const SearchTermChanged(term)),
        wait: debounceDuration,
        verify: (_) {
          verify(thesaurusRepository.search(term: term)).called(1);
        },
      );

      blocTest<SearchBloc, SearchState>(
        'emits [initial] when search term is empty',
        build: () => SearchBloc(thesaurusRepository),
        act: (bloc) => bloc.add(const SearchTermChanged('')),
        wait: debounceDuration,
        expect: const <SearchState>[
          SearchState.initial(),
        ],
      );

      blocTest<SearchBloc, SearchState>(
        'emits [loading, success] when search succeeds (empty)',
        build: () => SearchBloc(thesaurusRepository),
        act: (bloc) => bloc.add(const SearchTermChanged(term)),
        wait: debounceDuration,
        expect: const <SearchState>[
          SearchState.loading(),
          SearchState.success([]),
        ],
      );

      blocTest<SearchBloc, SearchState>(
        'emits [loading, success] when search succeeds (populated)',
        build: () {
          when(thesaurusRepository.search(
            term: anyNamed('term'),
            limit: anyNamed('limit'),
          )).thenAnswer((_) async => const <String>['kitty']);
          return SearchBloc(thesaurusRepository);
        },
        act: (bloc) => bloc.add(const SearchTermChanged(term)),
        wait: debounceDuration,
        expect: const <SearchState>[
          SearchState.loading(),
          SearchState.success([Suggestion('kitty')]),
        ],
      );

      blocTest<SearchBloc, SearchState>(
        'emits [success] when search succeeds and status is already success',
        build: () {
          when(thesaurusRepository.search(
            term: anyNamed('term'),
            limit: anyNamed('limit'),
          )).thenAnswer((_) async => const <String>['kitty']);
          return SearchBloc(thesaurusRepository)
            ..emit(const SearchState.success([]));
        },
        act: (bloc) => bloc.add(const SearchTermChanged(term)),
        wait: debounceDuration,
        expect: const <SearchState>[
          SearchState.success([Suggestion('kitty')]),
        ],
      );

      blocTest<SearchBloc, SearchState>(
        'emits [loading, failure] when search throws',
        build: () {
          when(thesaurusRepository.search(
            term: anyNamed('term'),
            limit: anyNamed('limit'),
          )).thenThrow(Exception('oops'));
          return SearchBloc(thesaurusRepository);
        },
        act: (bloc) => bloc.add(const SearchTermChanged(term)),
        wait: debounceDuration,
        expect: const <SearchState>[
          SearchState.loading(),
          SearchState.failure(),
        ],
      );

      blocTest<SearchBloc, SearchState>(
        'debounces events',
        build: () => SearchBloc(thesaurusRepository),
        act: (bloc) => bloc
          ..add(const SearchTermChanged('kitty'))
          ..add(const SearchTermChanged('cat')),
        wait: debounceDuration,
        verify: (_) {
          verifyNever(thesaurusRepository.search(term: 'kitty'));
          verify(thesaurusRepository.search(term: 'cat')).called(1);
        },
      );
    });
  });
}
