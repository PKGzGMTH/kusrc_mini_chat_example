import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './chatPage.dart';

class homePage extends StatelessWidget {
  homePage({super.key});

  final user = FirebaseAuth.instance.currentUser;

  CollectionReference friendCollection =
      FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text('Loginned with ${user!.email}')),
          Expanded(
            child: StreamBuilder(
              stream: friendCollection.snapshots(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        var friendList = snapshot.data!.docs[index];
                        if (user!.email != friendList['email']) {
                          return GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              child: ListTile(
                                leading: Icon(Icons.person),
                                title: Text(friendList['name']),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => chatPage(
                                          receiverEmail: friendList['email'],
                                          receiverID: friendList['uid'])));
                            },
                          );
                        } else {
                          return Container();
                        }
                      }));
                } else {
                  return Text('No data');
                }
              }),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute<void>(
          //     builder: (BuildContext context) => const MyPage(),
          //   ),
          // )
        }
      )

    );
  }
}
