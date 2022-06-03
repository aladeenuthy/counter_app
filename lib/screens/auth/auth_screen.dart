import 'package:flutter/material.dart';

import 'components/login.dart';
import 'components/signup.dart';

class AuthScreen extends StatefulWidget {
  final int? initialIndex ;
  const AuthScreen({Key? key, this.initialIndex}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.initialIndex ?? 0,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4.0),
                      blurRadius: 30.0,
                      color: Colors.black.withOpacity(0.06),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(25)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: const [
                    Expanded(
                      child: Icon(Icons.person, size: 70, color: Colors.purple),
                    ),
                    TabBar(
                      indicatorColor: Colors.purple,
                      labelColor: Colors.black,
                      tabs: [
                        Tab(text: "login"),
                        Tab(text: 'signup'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(
              flex: 5,
              child: TabBarView(
                children: [LoginScreen(), SignupScreen()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
