import 'dart:math';

import 'package:excuses_de_dev/controller/addExcuse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controller/generateExcuse.dart';
import '../model/excuse.dart';

class ExcuseButton extends StatefulWidget {
  final List<Excuse> excuses;
  const ExcuseButton({
    Key? key,
    required this.excuses,
  }) : super(key: key);

  @override
  State<ExcuseButton> createState() => _ExcuseButtonState();
}

class _ExcuseButtonState extends State<ExcuseButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(15),
            primary: Colors.lightGreen,
            fixedSize: const Size(400, 130),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80))),
        onPressed: () {
          //We change the state of loading to replace the text by the circular progress indicator
          setState(() {
            loading = true;
          });
          // After x seconds (with a random number between 1 and 5), we generate an Excuse and send it to the display route
          Future.delayed(Duration(seconds: Random().nextInt(5) + 1), () {
            setState(() {
              loading =
                  false; // we reset the loading otherwise if we go back to the page, we will still have the indicator.
            });
            Excuse? excuse = generateExcuse(widget.excuses);
            if (excuse != null) {
              Navigator.pushNamed(context, "/${excuse.httpCode}", arguments: {
                'excuse': excuse,
                'excuses': widget.excuses
              }); //We generate a new route with the httpCode. We pass the excuse and excuses array (so we won't have to call the API again)
            }
          });
        },
        child: loading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Text(
                "Générer une excuse",
                style: TextStyle(fontSize: 30),
              ));
  }
}

class AddButton extends StatefulWidget {
  List<Excuse> excuses;

  AddButton({
    Key? key,
    required this.excuses,
  }) : super(key: key);

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(15),
            primary: Colors.lightBlue,
            fixedSize: const Size(400, 130),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80))),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: SizedBox(
                    width: 600,
                    height: 600,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Ajouter une excuse",
                            style: TextStyle(fontSize: 30),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Code d'erreur"),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                        width: 200,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                //We will only allow numbers, so we won't have a int parse fail
                                                RegExp(r'[0-9]')),
                                          ],
                                          controller: codeController,
                                          validator: (value) {
                                            //We will validate each value
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Veuillez entrer un code';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Tag"),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                        width: 200,
                                        child: TextFormField(
                                          controller: tagController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Veuillez entrer un tag';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Message"),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                        width: 200,
                                        child: TextFormField(
                                          controller: messageController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Veuillez entrer un message';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 50),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(15),
                                        primary: Colors.lightBlue,
                                        fixedSize: const Size(150, 80),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        //when everything is ok, we create a new excuse with the values of controllers
                                        Excuse newExcuse = Excuse(
                                            httpCode:
                                                int.parse(codeController.text),
                                            tag: tagController.text,
                                            message: messageController.text);
                                        setState(() {
                                          widget.excuses.add(
                                              newExcuse); // we add the excuse to our array, which we will then parse.
                                          updateExcuses(widget
                                              .excuses); // We don't really need to use the received list since we've already updated it in our array.
                                        });
                                        Navigator.pushNamed(
                                            //Then we will immediately display the new excuse.
                                            context,
                                            "/${newExcuse.httpCode}",
                                            arguments: {
                                              'excuse': newExcuse,
                                              'excuses': widget.excuses
                                            });
                                      }
                                    },
                                    child: const Text(
                                      'Valider',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                  ),
                );
              });
        },
        child: const Text(
          "Ajouter une excuse",
          style: TextStyle(fontSize: 30),
        ));
  }
}
