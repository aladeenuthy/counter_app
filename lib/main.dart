import 'package:counter_app/helpers/key_helper.dart';
import 'package:counter_app/providers/auth_provider.dart';
import 'package:counter_app/providers/counter_provider.dart';
import 'package:counter_app/screens/auth/auth_screen.dart';
import 'package:counter_app/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(FirebaseAuth.instance)),
        Provider(create: (_) => CounterProvider(FirebaseDatabase.instance, FirebaseAuth.instance))
      ],
      child: MaterialApp(
        scaffoldMessengerKey: KeyHelper.scafKey,
        title: 'Counter',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.grey),
          inputDecorationTheme: const InputDecorationTheme(
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 19)),
          elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    minimumSize: const Size(double.infinity, 53),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))))
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Home();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            } else {
              return const AuthScreen();
            }
          },
        ),
      ),
    );
  }
}

