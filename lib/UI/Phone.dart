import 'package:flutter/material.dart';
class LogInWithPhoneNumber extends StatefulWidget {
  const LogInWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LogInWithPhoneNumber> createState() => _LogInWithPhoneNumberState();
}

class _LogInWithPhoneNumberState extends State<LogInWithPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(title: Text(
        'Phone'
      ),),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
