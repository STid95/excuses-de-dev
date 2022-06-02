import 'package:excuses_de_dev/navigation/error404.dart';
import 'package:excuses_de_dev/navigation/lost.dart';
import 'package:excuses_de_dev/navigation/message.dart';
import 'package:flutter/material.dart';

import 'navigation/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Fixed routes
      routes: {
        '/': (context) => const HomePage(),
        '/lost': (context) => const LostPage(),
      },

      //When we create a route by generating an excuse, it returns a new page and pass the fetched excuse and the excuses array.
      onGenerateRoute: (settings) {
        if (settings.arguments != null) {
          //We test if we have arguments to make sure it's a generated excuse and not a random route.
          return MaterialPageRoute(
              builder: (_) => MessagePage(
                  args: settings.arguments as Map<dynamic, dynamic>));
        } else {
          // Otherwise we send to the Error 404 Page since we don't know this route.
          return MaterialPageRoute(builder: (_) => const Error404Page());
        }
      },
      title: 'Excuses de dev',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
