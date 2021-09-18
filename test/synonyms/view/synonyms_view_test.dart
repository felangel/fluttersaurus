import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttersaurus/synonyms/synonyms.dart';
import 'package:mocktail/mocktail.dart';

class MockSynonymsCubit extends MockCubit<SynonymsState>
    implements SynonymsCubit {}

class FakeSynonymsState extends Fake implements SynonymsState {}

void main() {
  group('SynonymsView', () {
    const word = 'flutter';
    late SynonymsCubit synonymsCubit;

    setUpAll(() {
      registerFallbackValue(FakeSynonymsState());
    });

    setUp(() {
      synonymsCubit = MockSynonymsCubit();
      when(() => synonymsCubit.state).thenReturn(const SynonymsState.loading());
    });

    testWidgets('renders loading shimmer when state is loading',
        (tester) async {
      when(() => synonymsCubit.state).thenReturn(
        const SynonymsState.loading(word: word),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: synonymsCubit,
              child: const SynonymsView(),
            ),
          ),
        ),
      );
      expect(find.byKey(const Key('synonyms_loading_shimmer')), findsOneWidget);
    });

    testWidgets('renders SynonymsSuccess when state is success',
        (tester) async {
      when(() => synonymsCubit.state).thenReturn(
        const SynonymsState.success(word: word, synonyms: []),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: synonymsCubit,
              child: const SynonymsView(),
            ),
          ),
        ),
      );
      expect(find.byKey(const Key('synonyms_success_column')), findsOneWidget);
    });

    testWidgets('renders each synonym when state is success and has synomyms',
        (tester) async {
      final results = ['flap', 'dart', 'fleet'];
      final synonyms = results.map((result) => Synonym(result)).toList();
      when(() => synonymsCubit.state).thenReturn(
        SynonymsState.success(word: word, synonyms: synonyms),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: synonymsCubit,
              child: const SynonymsView(),
            ),
          ),
        ),
      );
      for (final result in results) {
        expect(find.text(result), findsOneWidget);
      }
    });

    testWidgets('renders SynonymsFailure when state is failure',
        (tester) async {
      when(() => synonymsCubit.state).thenReturn(const SynonymsState.failure());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: synonymsCubit,
              child: const SynonymsView(),
            ),
          ),
        ),
      );
      expect(find.byKey(const Key('synonyms_failure_center')), findsOneWidget);
    });
  });
}
