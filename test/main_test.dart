/// Tests main.dart.

import 'package:flutter_test/flutter_test.dart';
import 'package:renaissance_man/in_memory_repository.dart';

import 'package:renaissance_man/main.dart';

void main() {
  testWidgets('App has a title', (WidgetTester tester) async {
    await tester.pumpWidget(RenaissanceManApp(
      repository: InMemoryRepository(),
    ));
    await tester.pumpAndSettle();
    expect(find.text(RenaissanceManApp.appTitle), findsOneWidget);
  });
}
