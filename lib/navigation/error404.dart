import 'package:flutter/material.dart';

class Error404Page extends StatelessWidget {
  const Error404Page({Key? key}) : super(key: key);

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
            "Il n'y a rien ici !",
            style: TextStyle(fontSize: 50),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Image.asset("gif-error.gif"),
          ),
        ],
      )),
    );
  }
}
