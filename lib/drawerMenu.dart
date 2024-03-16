import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//เมนูทางด้านซ้ายมือ แสดงเมื่อกดไอคอนมุมบนซ้าย
class drawerMenu extends StatelessWidget {
  const drawerMenu({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    size: 64,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text('Home'),
                  leading: Icon(Icons.home),
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text('Setting'),
                  leading: Icon(Icons.settings),
                  onTap: () {},
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
              onTap: () {
                signUserOut();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
