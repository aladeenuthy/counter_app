import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';

final mockFirebaseUser = MockFirebaseUser();

class MockUserCredential extends Mock implements UserCredential {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  User? get currentUser => mockFirebaseUser;
}

class MockFirebaseUser extends Mock implements User {
  @override
  String? get displayName => 'aladeenuthy';
}
