import 'package:brillo_connetz_app/utility/dimen.dart';
import 'package:flutter/material.dart';
class NotAUserScreen extends StatefulWidget {
  const NotAUserScreen({Key? key}) : super(key: key);

  @override
  _NotAUserScreenState createState() => _NotAUserScreenState();
}

class _NotAUserScreenState extends State<NotAUserScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Container(
      margin: const EdgeInsets.symmetric(horizontal: kMargin),
      child: const Center(
        child: Text("OOPs!!! You are not a user again. \n What went wrong?"),
      )
    )));
  }
}
