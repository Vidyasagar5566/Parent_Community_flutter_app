import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '/Login/login.dart';
import '/Firstpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocalStorage storage = LocalStorage("usertoken");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: storage.ready,
        builder: (context, snapshop) {
          if (snapshop.data == null) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (storage.getItem('token') == null) {
            return loginpage("", 'Nit Calicut');
          }
          return get_ueser_widget(0);
        },
      ),
    );
  }
}
