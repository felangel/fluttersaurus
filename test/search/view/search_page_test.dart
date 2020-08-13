import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttersaurus/search/search.dart';
import 'package:mockito/mockito.dart';
import 'package:thesaurus_repository/thesaurus_repository.dart';

class MockThesaurusRepository extends Mock implements ThesaurusRepository {}

void main() {
  group('SearchPage', () {
    ThesaurusRepository thesaurusRepository;

    setUp(() {
      thesaurusRepository = MockThesaurusRepository();
      when(thesaurusRepository.search(term: anyNamed('term')))
          .thenAnswer((_) async => const <String>[]);
    });

    testWidgets('renders a SearchForm', (tester) async {
      await tester.pumpWidget(RepositoryProvider.value(
        value: thesaurusRepository,
        child: MaterialApp(home: SearchPage()),
      ));
      await tester.pumpAndSettle();
      expect(find.byType(SearchForm), findsOneWidget);
    });
  });
}
