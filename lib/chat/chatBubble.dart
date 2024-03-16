import 'package:flutter/material.dart';

//Bubble หน้าแชท

class chatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const chatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //ถ้าเป็น user ที่ login ให้ bubble เป็นสีฟ้า ถ้าไม่ใช่เป็นสีเทา
        color: isCurrentUser ? Colors.blue.shade200 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 2),
      child: Text(message),
    );
  }
}
