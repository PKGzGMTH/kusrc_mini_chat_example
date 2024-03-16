import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './messageModel.dart';

class chatService {
  //get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //ฟังก์ชันสำหรับส่งข้อความ
  Future<void> sendMessage(String receiverID, message) async {
    //ดึงข้อมูลผู้ใช้คนที่ login
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //สร้าง message ใหม่
    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);

    //สร้างห้องแชทสำหรับสองคน
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    //เพิ่มข้อมูลใหม่ในฐานข้อมูล
    await _firestore
        .collection('chatRooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //ดึง messages มาแสดง
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    //สร้างห้องแชทสำหรับสองคน
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    //ดึงข้อมูลจาก collection ชื่อ chatRooms ใน doc ห้องแชทของคนสองคนที่กำหนด
    return _firestore
        .collection('chatRooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
