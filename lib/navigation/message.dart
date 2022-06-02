import 'package:excuses_de_dev/composants/mainComposant.dart';
import 'package:flutter/material.dart';

import '../model/excuse.dart';

class MessagePage extends StatefulWidget {
  final Map<dynamic, dynamic> args;
  const MessagePage({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  Excuse? excuse;
  List<Excuse> excuses = [];
  @override
  void initState() {
    //In init, we fetch the arguments passed to the road
    excuse = widget.args['excuse'];
    excuses = widget.args['excuses'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainComposant(message: excuse!.message, excuses: excuses);
  }
}
