import 'package:counter_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:counter_app/providers/auth_provider.dart';
import 'package:counter_app/providers/counter_provider.dart';
import "../mocks/mock.dart";

void main() {
  late MockFirebaseDatabase mockFirebaseDatabase;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseDatabase = MockFirebaseDatabase();
  });
  Widget buldWidget() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(mockFirebaseAuth)),
        Provider(
            create: (_) =>
                CounterProvider(mockFirebaseDatabase, mockFirebaseAuth))
      ],
      child: const MaterialApp(
        title: 'Counter',
        home: Home(),
      ),
    );
  }

  testWidgets("username is displayed in appbar when screen loaded",
      (WidgetTester tester) async {
    await tester.pumpWidget(buldWidget());
    final usernameTextWidget =
        find.text(mockFirebaseAuth.currentUser?.displayName as String);
    expect(usernameTextWidget, findsOneWidget);
  });

  testWidgets('log out button is renderered', (WidgetTester tester) async {
    await tester.pumpWidget(buldWidget());
    final fButton = find.byIcon(Icons.logout);
    expect(fButton, findsOneWidget);
  });

}
