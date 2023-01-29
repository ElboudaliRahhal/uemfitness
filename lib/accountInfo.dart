import 'package:flutter/material.dart';

class AccountInfo extends StatelessWidget {
  final String username;
  final String password;
  final String email;

  AccountInfo({required this.username, required this.password, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Information'),
      ),
      body: Column(
        children: <Widget>[
          Text('Username: $username'),
          Text('Password: $password'),
          Text('Email: $email'),
        ],
      ),
    );
  }
}
