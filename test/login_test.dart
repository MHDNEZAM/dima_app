import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dima_app/screens/login_screen.dart';

import 'package:dima_app/main.dart';

/*
void main() {
  group('Login', () {




    test('value should start at 0', () {
      expect(Counter().value, 0);
    });

    test('value should be incremented', () {
      final counter = Counter();

      counter.increment();

      expect(counter.value, 1);
    });

    test('value should be decremented', () {
      final counter = Counter();

      counter.decrement();

      expect(counter.value, -1);
    });
  });
}*/

void main() {
//The login component
  String email = 'test@test.com';
  String password = '123456';

  testWidgets('empty email and password', (WidgetTester tester) async {
    await Firebase.initializeApp();
    final _auth = FirebaseAuth.instance;
    final user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

//expect((tester.widget(loginButton) as PrimaryButton).enabled, isFalse);
    expect(user != null, isFalse);
  });
}
