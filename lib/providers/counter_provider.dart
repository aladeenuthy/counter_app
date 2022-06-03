import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class CounterProvider {
  late FirebaseDatabase database;
  late FirebaseAuth auth;
  CounterProvider(this.database, this.auth);

  Stream<DatabaseEvent> getCounter() {
    return database
        .ref('counter_storage')
        .child(auth.currentUser?.displayName ?? "")
        .onValue;
  }

  Future<String> increment() async {
    final snapshot = await database
        .ref('counter_storage')
        .child(auth.currentUser?.displayName ??
            FirebaseAuth.instance.currentUser!.displayName as String)
        .get();
    if (snapshot.exists) {
      Map<String, dynamic> data = jsonDecode(jsonEncode(snapshot.value ?? {}));
      var add = data.isEmpty ? 1 : data['counter'] + 1;
      await database
          .ref('counter_storage')
          .child(auth.currentUser?.displayName ??
              '')
          .set({'counter': add});
      return "snapshot exist and increments past data";
    }
    await database
        .ref('counter_storage')
        .child(auth.currentUser?.displayName ??
            '')
        .set({'counter': 1});
    return "snapshot doesn't exist set value to 1";
  }
}
