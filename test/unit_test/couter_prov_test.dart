import 'package:counter_app/providers/counter_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../mocks/mock.dart';

void main() {
  late CounterProvider sut;
  late MockFirebaseDatabase mockFirebaseDatabase;
  late MockFirebaseAuth mockFirebaseAuth;
  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseDatabase = MockFirebaseDatabase();
    sut = CounterProvider(mockFirebaseDatabase, mockFirebaseAuth);
  });
  test('emit of counter occurs', () {
    expectLater(sut.getCounter(), emitsInOrder([mockDataBaseEvent]));
  });

  test("increment method test if snapshot exists", () async {
    when(() => mockDataSnapshot.exists).thenReturn(false);
    final result = await sut.increment();
    expect(result, "snapshot doesn't exist set value to 1");
  });

  test("increment method test if snapshot does not  exists", () async {
    when(() => mockDataSnapshot.exists).thenReturn(true);
    final result = await sut.increment();
    expect(result, "snapshot exist and increments past data");
  });
}
