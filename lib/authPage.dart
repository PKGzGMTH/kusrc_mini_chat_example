import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './homePage.dart';
import './loginPage.dart';
import './drawerMenu.dart';

class authPage extends StatelessWidget {
  const authPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: drawerMenu(),
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //Logged in
            if (snapshot.hasData) {
              return homePage();
            } else {
              //NOT logged in
              return loginPage();
            }
          }),
    );
  }
}
