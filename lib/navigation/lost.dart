import 'package:flutter/material.dart';

class LostPage extends StatefulWidget {
  const LostPage({Key? key}) : super(key: key);

  @override
  State<LostPage> createState() => _LostPageState();
}

class _LostPageState extends State<LostPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, "/");
    });
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "I'm lost...",
            style: TextStyle(fontSize: 50),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Image.asset("gif-lost.gif"),
          ),
        ],
      )),
    );
  }
}
