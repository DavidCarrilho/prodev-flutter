import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:appprodev/ui/pages/pages.dart';

void main() {
  testWidgets('Should load with correct initial state', (WidgetTester tester) async {
    // arrange
    final loginPage = MaterialApp(home: LoginPage());
    await tester.pumpWidget(loginPage);

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text),
    );
    expect(
      emailTextChildren,
      findsOneWidget,
      reason:'When a TextFormField has only onde text child, means it has NO ERROS, since one of the childs is alwas the hint text',
    );

    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text),
    );
    expect(
      passwordTextChildren,
      findsOneWidget,
      reason:'When a TextFormField has only onde text child, means it has NO ERROS, since one of the childs is alwas the hint text',
    );

    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(button.onPressed, null);
  });
}
