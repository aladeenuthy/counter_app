import 'dart:convert';
import 'package:counter_app/providers/auth_provider.dart';
import 'package:counter_app/providers/counter_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<AuthProvider>(context, listen: false).auth.currentUser?.displayName ?? ""),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
              onPressed: () {
                authProv.logout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<DatabaseEvent>(
          stream:
              Provider.of<CounterProvider>(context, listen: false).getCounter(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> data =
                  jsonDecode(jsonEncode(snapshot.data?.snapshot.value ?? {}));
              var value = data['counter'] == null ? "0" : data['counter'].toString();
              return Center(
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 30),
                ),
              );
            }else if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              );
            }
          return const  Center(
              child: Text(
                "0",
                style: TextStyle(fontSize: 30),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        key: const ValueKey('floating_action_button'),
        onPressed: () {
          Provider.of<CounterProvider>(context, listen: false).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
