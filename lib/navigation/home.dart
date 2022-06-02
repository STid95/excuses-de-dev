import 'package:excuses_de_dev/composants/mainComposant.dart';
import 'package:excuses_de_dev/controller/fetchExcuses.dart';
import 'package:flutter/material.dart';

import '../model/excuse.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Excuse> excuses = [];

  @override
  void initState() {
    initExcuses();
    super.initState();
  }

  initExcuses() async {
    excuses = await fetchExcuses();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MainComposant(
        message: "Bienvenue sur Excuses de Dev !", excuses: excuses);
  }
}
