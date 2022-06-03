import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:counter_app/providers/auth_provider.dart';
import '../mocks/firebase_auth_mock.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late AuthProvider sut;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    sut = AuthProvider(mockFirebaseAuth);
  });

  test("create user", () async {
    when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
        email: "test@test.com", password: "marine345")).thenAnswer((_) async {
      return MockUserCredential();
    });
    when(() => mockFirebaseUser.updateDisplayName(any()))
        .thenAnswer((_) async {
      return;
    });
    expect(sut.isLoading, false);
    final future = sut.signUp("username", 'test@test.com', "marine345");
    expect(sut.isLoading, true);
    final result = await future;
    verify(() => mockFirebaseUser.updateDisplayName(any())).called(1);
    expect(sut.isLoading, false);
    expect(result, true);
  });

  test("create user with exception", () async {
    when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
        email: "test@test.com", password: "marine345")).thenAnswer((_) async {
      throw FirebaseAuthException(message: "error", code: "wrong");
    });
    expect(sut.isLoading, false);
    final future = sut.signUp("username", 'test@test.com', "marine345");
    expect(sut.isLoading, true);
    final result = await future;
    expect(sut.isLoading, false);
    expect(result, false);
  });

  test("login user", () async {
    when(() => mockFirebaseAuth.signInWithEmailAndPassword(
        email: "test@test.com", password: "marine345")).thenAnswer((_) async {
      return MockUserCredential();
    });
    expect(sut.isLoading, false);
    final future = sut.login('test@test.com', "marine345");
    expect(sut.isLoading, true);
    final result = await future;
    expect(sut.isLoading, false);
    expect(result, true);
  });

  test("login user exception", () async {
    when(() => mockFirebaseAuth.signInWithEmailAndPassword(
        email: "test@test.com", password: "marine345")).thenAnswer((_) async {
      throw FirebaseAuthException(message: "error", code: "wrong");
    });
    expect(sut.isLoading, false);
    final future = sut.login('test@test.com', "marine345");
    expect(sut.isLoading, true);
    final result = await future;
    expect(sut.isLoading, false);
    expect(result, false);
  });

  test("logout user ", () async {
    when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async {
      return;
    });
    final result = await sut.logout();
    expect(result, true);
  });

  test("logout user with exception ", () async {
    when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async {
      throw FirebaseAuthException(code: "signout", message: "error occured");
    });
    final result = await sut.logout();
    expect(result, false);
  });
}
