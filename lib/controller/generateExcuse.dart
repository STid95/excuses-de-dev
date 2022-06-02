import 'dart:math';

import 'package:excuses_de_dev/model/excuse.dart';

Excuse? generateExcuse(List<Excuse> excuses, {Excuse? currentExcuse}) {
  final random = Random();
  int excuseIndex;

  try {
    if (currentExcuse != null) {
      //if we already have an excuse currently displayed, we don't want to display it again.
      do {
        excuseIndex = random.nextInt(excuses.length);
      } while (excuseIndex ==
          excuses.indexOf(
              currentExcuse)); // We loop until the random int is different from the index of the excuse.
      return excuses[
          excuseIndex]; //then when we're out of the loop we return the excuse
    } else {
      return excuses[random.nextInt(excuses
          .length)]; // Otherwise, we return the excuse without further tests
    }
  } catch (e) {
    print(e);
  }
  return null;
}
