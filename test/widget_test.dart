import 'package:flutter_test/flutter_test.dart';

import 'package:todo_refatoracao_baguncado/app/app.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const AppRoot());
    expect(find.text('Todos'), findsOneWidget);
  });
}
