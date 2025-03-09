import 'package:flutter/material.dart';
import 'package:nimraapi/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'order_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Driver Login")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email")),
            TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool loggedIn =
                    await Provider.of<AuthProvider>(context, listen: false)
                        .login(_emailController.text, _passwordController.text);

                if (loggedIn) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => OrderScreen()));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Login failed")));
                }
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
