import 'package:flutter/material.dart';

import 'package:excuses_de_dev/composants/buttons.dart';

import '../model/excuse.dart';

class MainComposant extends StatefulWidget {
  final String message;
  final List<Excuse> excuses;
  const MainComposant({
    Key? key,
    required this.message,
    required this.excuses,
  }) : super(key: key);

  @override
  State<MainComposant> createState() => _MainComposantState();
}

class _MainComposantState extends State<MainComposant>
    with TickerProviderStateMixin {
  //Controller to change the position of text to vertical to the start of the column.
  late final AnimationController slideTextController = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<Offset> _offsetTitle =
      Tween<Offset>(begin: const Offset(0.0, 3.0), end: Offset.zero)
          .animate(CurvedAnimation(
    parent: slideTextController,
    curve: Curves.easeOutCirc,
  ));

  //controller to change the opacity of the button
  late final AnimationController opacityBtnController =
      AnimationController(vsync: this, duration: const Duration(seconds: 1));
  late final Animation<double> _opacityBtn =
      Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
    parent: opacityBtnController,
    curve: Curves.easeOutCirc,
  ));

  //controller to change the opacity of the text
  late final AnimationController opacityTextController =
      AnimationController(vsync: this, duration: const Duration(seconds: 1));
  late final Animation<double> _opacityText =
      Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
    parent: opacityTextController,
    curve: Curves.easeIn,
  ));

  @override
  void initState() {
    // First we make the text appear with a fade in
    opacityTextController.forward().whenComplete(() {
      //When the text is visible, we wait 2 secondes before making the text slide and the button appear.
      Future.delayed(const Duration(seconds: 2), () {
        opacityBtnController.forward();
        slideTextController.forward();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    slideTextController.dispose();
    opacityTextController.dispose();
    opacityBtnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _opacityText,
                child: SlideTransition(
                  position: _offsetTitle,
                  child: Text(
                    widget.message,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 50),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FadeTransition(
                      opacity: _opacityBtn,
                      child: ExcuseButton(excuses: widget.excuses)),
                  FadeTransition(
                      opacity: _opacityBtn,
                      child: AddButton(excuses: widget.excuses)),
                ],
              ),
            ]),
      ),
    );
  }
}
