/// Tests main.dart.

import 'package:flutter_test/flutter_test.dart';

import 'package:renaissance_man/main.dart';

void main() {
  testWidgets('App has a title', (WidgetTester tester) async {
    await tester.pumpWidget(const RenaissanceManApp());
    expect(find.text(RenaissanceManApp.titleText), findsOneWidget);
  });
}
