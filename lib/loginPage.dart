import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './forgotPasswordPage.dart';
import './registPage.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 200,
                height: 200,
                margin: EdgeInsets.only(top: 30, bottom: 10),
                padding: EdgeInsets.all(10),
                // decoration: BoxDecoration(
                //     color: Colors.grey[200], shape: BoxShape.circle),
                child: Icon(Icons.message,
                    size: 150, color: Color.fromRGBO(155, 184, 205, 1)),
              ),
            ),
            SizedBox(height: 15),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    // autofocus: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.mail),
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'กรุณากรอก email';
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'กรุณากรอกรหัสผ่าน';
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        forgotPasswordPage()));
                          },
                          child: Text('Forgot Password?')),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        signUserIn();
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(155, 184, 205, 1)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Text('Or continue with'),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Color.fromRGBO(229, 217, 182, 1),
                  child: Icon(Icons.mail_outline, color: Colors.white),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Color.fromRGBO(229, 217, 182, 1),
                  child: Icon(Icons.facebook, color: Colors.white),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Color.fromRGBO(229, 217, 182, 1),
                  child: Icon(Icons.apple, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => registPage()));
                    },
                    child: Text('Register now'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
