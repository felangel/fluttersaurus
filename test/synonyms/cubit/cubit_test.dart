import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttersaurus/synonyms/synonyms.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thesaurus_repository/thesaurus_repository.dart';

class MockThesaurusRepository extends Mock implements ThesaurusRepository {}

void main() {
  group('SynonymsCubit', () {
    late ThesaurusRepository thesaurusRepository;

    setUp(() {
      thesaurusRepository = MockThesaurusRepository();
    });

    test('initial state is SynonymsState.loading', () {
      final synonymsCubit = SynonymsCubit(thesaurusRepository);
      expect(synonymsCubit.state, const SynonymsState.loading());
      synonymsCubit.close();
    });

    group('getSynonyms', () {
      const word = 'flutter';

      setUp(() {
        when(
          () => thesaurusRepository.synonyms(
            word: any(named: 'word'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => <String>[]);
      });

      blocTest<SynonymsCubit, SynonymsState>(
        'invokes synonyms on thesaurusRepository',
        build: () => SynonymsCubit(thesaurusRepository),
        act: (cubit) => cubit.getSynonyms(word: word),
        verify: (_) {
          verify(() => thesaurusRepository.synonyms(word: word)).called(1);
        },
      );

      blocTest<SynonymsCubit, SynonymsState>(
        'emits [loading, success] when synonyms succeeds (empty)',
        build: () => SynonymsCubit(thesaurusRepository),
        act: (cubit) => cubit.getSynonyms(word: word),
        expect: () => const <SynonymsState>[
          SynonymsState.loading(word: word),
          SynonymsState.success(word: word, synonyms: <Synonym>[]),
        ],
      );

      blocTest<SynonymsCubit, SynonymsState>(
        'emits [loading, success] when synonyms succeeds (populated)',
        build: () {
          when(
            () => thesaurusRepository.synonyms(
              word: any(named: 'word'),
              limit: any(named: 'limit'),
            ),
          ).thenAnswer((_) async => <String>['flap']);
          return SynonymsCubit(thesaurusRepository);
        },
        act: (cubit) => cubit.getSynonyms(word: word),
        expect: () => const <SynonymsState>[
          SynonymsState.loading(word: word),
          SynonymsState.success(
            word: word,
            synonyms: <Synonym>[Synonym('flap')],
          ),
        ],
      );

      blocTest<SynonymsCubit, SynonymsState>(
        'emits [loading, failure] when synonyms throws',
        build: () {
          when(
            () => thesaurusRepository.synonyms(
              word: any(named: 'word'),
              limit: any(named: 'limit'),
            ),
          ).thenThrow(Exception('oops'));
          return SynonymsCubit(thesaurusRepository);
        },
        act: (cubit) => cubit.getSynonyms(word: word),
        expect: () => const <SynonymsState>[
          SynonymsState.loading(word: word),
          SynonymsState.failure(),
        ],
      );
    });
  });
}
