import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:giuaky/main.dart';
import 'package:giuaky/presentation/screens/Login.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), // lắng nghe login/logout
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return MyHomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
