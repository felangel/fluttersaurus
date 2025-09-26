import 'package:flutter_test/flutter_test.dart';
import 'package:fluttersaurus/fluttersaurus.dart';
import 'package:fluttersaurus/search/search.dart';

void main() {
  group('Fluttersaurus', () {
    testWidgets('renders SearchPage', (
      tester,
    ) async {
      await tester.pumpWidget(const Fluttersaurus());
      expect(find.byType(SearchPage), findsOneWidget);
    });
  });
}
