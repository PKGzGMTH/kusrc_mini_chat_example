import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './chat/chatBubble.dart';
import './chat/chatService.dart';

//หน้าแชท
class chatPage extends StatelessWidget {
  //ข้อมูลผู้รับ
  final String receiverEmail;
  final String receiverID;

  chatPage({super.key, required this.receiverEmail, required this.receiverID});

  final _messageController = TextEditingController();

  //เรียกใช้ class chatService ในไฟล์ chatService.dart
  final chatService _chatService = chatService();

  //ดึงข้อมูลผู้ใช้ที่กำลัง login
  final user = FirebaseAuth.instance.currentUser;

  //send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageController.text);

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(child: _buildMessageList()),
            _buildUserInput(),
          ],
        ),
      ),
    );
  }

  //แสดงข้อมูลในหน้าแชท
  Widget _buildMessageList() {
    String senderID = user!.uid;

    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text('Error');
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        //return list view
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  //แสดง message ของผู้รับและผู้ส่งทั้งหมด
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == user!.uid;
    var _alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: _alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          chatBubble(message: data['message'], isCurrentUser: isCurrentUser),
        ],
      ),
    );
  }

  //TextFormField และปุ่มส่งข้อความในหน้าแชท
  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _messageController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Type a message',
            ),
          ),
        ),
        IconButton(
            onPressed: sendMessage,
            icon: Icon(
              Icons.send,
              color: Colors.blue,
            )),
      ],
    );
  }
}
