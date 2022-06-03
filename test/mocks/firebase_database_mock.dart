import 'package:firebase_database/firebase_database.dart';
import 'package:mocktail/mocktail.dart';
final mockDataBaseEvent = MockDataBaseEvent();
final mockDataSnapshot = MockDataSnapshot();

class MockDataSnapshot extends Mock implements DataSnapshot {
}

class MockDataBaseEvent extends Mock implements DatabaseEvent {}

class MockDatabaseReference extends Mock implements DatabaseReference {
  @override
  DatabaseReference child(String path) {
    return MockDatabaseReference();
  }

  @override
  Future<void> set(Object? value) async {
    return;
  }

  @override
  Future<DataSnapshot> get() async {
    return mockDataSnapshot;
  }

  @override
  Stream<DatabaseEvent> get onValue => Stream.fromIterable([mockDataBaseEvent]);
}

class MockFirebaseDatabase extends Mock implements FirebaseDatabase {
  @override
  DatabaseReference ref([String? path]) {
    return MockDatabaseReference();
  }
}
