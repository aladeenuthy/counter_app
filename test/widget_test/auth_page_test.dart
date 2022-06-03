import 'package:counter_app/providers/auth_provider.dart';
import 'package:counter_app/providers/counter_provider.dart';
import 'package:counter_app/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../mocks/mock.dart';
void main() {
    late MockFirebaseDatabase mockFirebaseDatabase;
    late MockFirebaseAuth mockFirebaseAuth;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockFirebaseDatabase = MockFirebaseDatabase();
    });
    Widget buldWidget(int initialIndexToSwitchBetweenLoginandSignUpScreen) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(mockFirebaseAuth)),
        Provider(
            create: (_) =>
                CounterProvider(mockFirebaseDatabase, mockFirebaseAuth))
      ],
      child: MaterialApp(
        title: 'Counter',
        home: AuthScreen(initialIndex: initialIndexToSwitchBetweenLoginandSignUpScreen,),
      ),
    );
  }



    group('login screen', () {
    testWidgets(
        'calls logic and loading spinner is rendered  when login button is tapped when inputs are given ',
        (WidgetTester tester) async {
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'test@test.com', password: 'marine345')).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 4));
        return MockUserCredential();
      });
      await tester.pumpWidget(buldWidget(0));
      final eButton = find.byKey(const Key('login-elevatedbutton'));
      final emailInput = find.byKey(const Key('Email address'));
      final passwordInput = find.byKey(const Key('Password'));
      await tester.enterText(emailInput, 'test@test.com');
      await tester.enterText(passwordInput, 'marine345');
      await tester.tap(eButton);
      await tester.pump(const Duration(milliseconds: 500));
      final spinner = find.byType(CircularProgressIndicator);
      expect(spinner, findsOneWidget);
      tester.pumpAndSettle();
    });
    testWidgets(
        'does not call logic and loading spinner is not rendered  when login button is tapped and  when inputs are not given',
        (WidgetTester tester) async {
      await tester.pumpWidget(buldWidget(0));
      final eButton = find.byType(ElevatedButton);
      await tester.tap(eButton);
      await tester.pump(const Duration(milliseconds: 500));
      final spinner = find.byType(CircularProgressIndicator);
      expect(spinner, findsNothing);
    });
  });

  group('signup screen', () {
    testWidgets(
        'calls logic and loading spinner is rendered  when signup button is tapped when inputs are given ',
        (WidgetTester tester) async {
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'test@test.com', password: 'marine345')).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 4));
        return MockUserCredential();
      });
      await tester.pumpWidget(buldWidget(1));
      final eButton = find.byKey(const Key('signup-elevatedbutton'));
      final usernameInput = find.byKey(const Key('username'));
      final emailInput = find.byKey(const Key('Email address'));
      final passwordInput = find.byKey(const Key('Password'));
      await tester.enterText(usernameInput, 'username');
      await tester.enterText(emailInput, 'test@test.com');
      await tester.enterText(passwordInput, 'marine345');
      await tester.tap(eButton);
      await tester.pump(const Duration(milliseconds: 500));
      final spinner = find.byType(CircularProgressIndicator);
      expect(spinner, findsOneWidget);
      tester.pumpAndSettle();
    });

      testWidgets(
        'does not call logic and loading spinner is not rendered  when signup button is tapped and  when inputs are not given',
        (WidgetTester tester) async {
      await tester.pumpWidget(buldWidget(0));
      final eButton = find.byType(ElevatedButton);
      await tester.tap(eButton);
      await tester.pump(const Duration(milliseconds: 500));
      final spinner = find.byType(CircularProgressIndicator);
      expect(spinner, findsNothing);
    });
  });
  
}