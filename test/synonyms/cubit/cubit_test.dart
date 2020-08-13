import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttersaurus/synonyms/synonyms.dart';
import 'package:mockito/mockito.dart';
import 'package:thesaurus_repository/thesaurus_repository.dart';

class MockThesaurusRepository extends Mock implements ThesaurusRepository {}

void main() {
  group('SynonymsCubit', () {
    ThesaurusRepository thesaurusRepository;

    setUp(() {
      thesaurusRepository = MockThesaurusRepository();
    });

    test('throws AssertionError when thesaurusRepository is null', () {
      expect(() => SynonymsCubit(null), throwsAssertionError);
    });

    test('initial state is SynonymsState.loading', () {
      final synonymsCubit = SynonymsCubit(thesaurusRepository);
      expect(synonymsCubit.state, const SynonymsState.loading());
      synonymsCubit.close();
    });

    group('getSynonyms', () {
      const word = 'flutter';

      setUp(() {
        when(thesaurusRepository.synonyms(
          word: anyNamed('word'),
          limit: anyNamed('limit'),
        )).thenAnswer((_) async => <String>[]);
      });

      blocTest<SynonymsCubit, SynonymsState>(
        'invokes synonyms on thesaurusRepository',
        build: () => SynonymsCubit(thesaurusRepository),
        act: (cubit) => cubit.getSynonyms(word: word),
        verify: (_) {
          verify(thesaurusRepository.synonyms(word: word)).called(1);
        },
      );

      blocTest<SynonymsCubit, SynonymsState>(
        'emits [loading, success] when synonyms succeeds (empty)',
        build: () => SynonymsCubit(thesaurusRepository),
        act: (cubit) => cubit.getSynonyms(word: word),
        expect: const <SynonymsState>[
          SynonymsState.loading(),
          SynonymsState.success(<Synonym>[]),
        ],
      );

      blocTest<SynonymsCubit, SynonymsState>(
        'emits [loading, success] when synonyms succeeds (populated)',
        build: () {
          when(thesaurusRepository.synonyms(
            word: anyNamed('word'),
            limit: anyNamed('limit'),
          )).thenAnswer((_) async => <String>['flap']);
          return SynonymsCubit(thesaurusRepository);
        },
        act: (cubit) => cubit.getSynonyms(word: word),
        expect: const <SynonymsState>[
          SynonymsState.loading(),
          SynonymsState.success(<Synonym>[Synonym('flap')]),
        ],
      );

      blocTest<SynonymsCubit, SynonymsState>(
        'emits [loading, failure] when synonyms throws',
        build: () {
          when(thesaurusRepository.synonyms(
            word: anyNamed('word'),
            limit: anyNamed('limit'),
          )).thenThrow(Exception('oops'));
          return SynonymsCubit(thesaurusRepository);
        },
        act: (cubit) => cubit.getSynonyms(word: word),
        expect: const <SynonymsState>[
          SynonymsState.loading(),
          SynonymsState.failure(),
        ],
      );
    });
  });
}
