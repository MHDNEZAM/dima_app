import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dima_app/screens/login_screen.dart';

import 'package:dima_app/main.dart';

void main() {
  //The login component
  testWidgets('empty email and password', (WidgetTester tester) async {
    var app = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: LoginScreen()));
    await tester.pumpWidget(app);

    Finder email = find.byKey(new Key('email'));
    Finder pwd = find.byKey(new Key('password'));

    print("Getting email widget");
    print(email.toString());
    final field = TextFormField(
      initialValue: "hello",
      key: Key('textformfield'),
      maxLines: 2,
    );
    //expect((tester.widget(loginButton) as PrimaryButton).enabled, isFalse);
    expect(email.evaluate(), isFalse);
  });
}
