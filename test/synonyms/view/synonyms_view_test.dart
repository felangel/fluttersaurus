import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttersaurus/search/search.dart';
import 'package:fluttersaurus/synonyms/synonyms.dart';
import 'package:mockito/mockito.dart';

class MockSynonymsCubit extends MockBloc<SearchState> implements SynonymsCubit {
}

void main() {
  group('SynonymsView', () {
    const word = 'flutter';
    SynonymsCubit synonymsCubit;

    setUp(() {
      synonymsCubit = MockSynonymsCubit();
      when(synonymsCubit.state).thenReturn(const SynonymsState.loading());
    });

    testWidgets('renders loading shimmer when state is loading',
        (tester) async {
      when(synonymsCubit.state).thenReturn(const SynonymsState.loading());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: synonymsCubit,
              child: const SynonymsView(word: word),
            ),
          ),
        ),
      );
      expect(find.byKey(const Key('synonyms_loading_shimmer')), findsOneWidget);
    });

    testWidgets('renders SynonymsSuccess when state is success',
        (tester) async {
      when(synonymsCubit.state).thenReturn(const SynonymsState.success([]));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: synonymsCubit,
              child: const SynonymsView(word: word),
            ),
          ),
        ),
      );
      expect(find.byKey(const Key('synonyms_success_column')), findsOneWidget);
    });

    testWidgets('renders SynonymsFailure when state is failure',
        (tester) async {
      when(synonymsCubit.state).thenReturn(const SynonymsState.failure());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: synonymsCubit,
              child: const SynonymsView(word: word),
            ),
          ),
        ),
      );
      expect(find.byKey(const Key('synonyms_failure_center')), findsOneWidget);
    });
  });
}
