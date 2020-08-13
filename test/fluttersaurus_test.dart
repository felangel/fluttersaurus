import 'package:flutter_test/flutter_test.dart';
import 'package:fluttersaurus/fluttersaurus.dart';
import 'package:fluttersaurus/search/search.dart';
import 'package:mockito/mockito.dart';
import 'package:thesaurus_repository/thesaurus_repository.dart';

class MockThesaurusRepository extends Mock implements ThesaurusRepository {}

void main() {
  group('Fluttersaurus', () {
    test('throws AssertionError when thesaurusRepository is null', () {
      expect(
        () => Fluttersaurus(thesaurusRepository: null),
        throwsAssertionError,
      );
    });

    testWidgets('renders SearchPage when thesaurusRepository is not null',
        (tester) async {
      await tester.pumpWidget(Fluttersaurus(
        thesaurusRepository: MockThesaurusRepository(),
      ));
      expect(find.byType(SearchPage), findsOneWidget);
    });
  });
}
