import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:giuaky/application/UserViewModel.dart';
import 'package:giuaky/presentation/screens/UserListScreen.dart';
import 'data/UserFirebase.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => UserFirebase()),
        ChangeNotifierProvider(
          create: (context) => UserViewModel(
          userFirebase: context.read(),
        ))
  ],
     child: const MyApp()
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var db = FirebaseFirestore.instance;
  final user = <String, dynamic>{
    "first": "Ada",
    "last": "Lovelace",
    "born": 1815
  };
  var current = "null";
  void addSample() {
    db.collection("Users").add(user).then((DocumentReference doc) {
      current = doc.id;
      print('DocumentSnapshot added with ID: ${doc.id}');
      notifyListeners();
    }).catchError((error) {
      print('🔥 Lỗi khi thêm user: $error');
    });
  }

}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(child: UserListScreen(viewModel: context.read())),
          ],
        ),
      ),
    );
  }


}