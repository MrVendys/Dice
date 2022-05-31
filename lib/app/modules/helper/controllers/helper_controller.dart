// ignore_for_file: unnecessary_overrides

import 'package:dices/app/models/dice.dart';
import 'package:dices/app/modules/helper/classes/check_dices.dart';
import 'package:dices/app/modules/helper/classes/figure.dart';
import 'package:dices/app/services/score_service.dart';
import 'package:dices/app/shared/data/figures.dart';

import 'package:get/get.dart';

class HelperController extends GetxController {
  final scoreService = Get.find<ScoreService>();
  RxList<Dice> rolledDices = <Dice>[].obs;
  List<Figure> figures = [];

  @override
  void onInit() {
    rolledDices = [scoreService.rolledDices, scoreService.stoppedDices]
        .expand((x) => x)
        .toList()
        .obs;

    calculate(rolledDices);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  calculate(RxList<Dice> dices) {
    List<int> values = [];
    // dices.forEach((dice) {
    //   values.add(dice.number);
    // });
    for (final dice in dices) {
      values.add(dice.number);
    }
    CheckDices checkDices = CheckDices(values);

    for (var i = 17; i >= 0; i--) {
      int diceCount = 0;
      for (int count in checkDices.listy[i]) {
        diceCount += count;
      }
      int possibilitys = 1;
      int goodPossibilitys = 1;
      for (var j = 0; j < 6 - checkDices.listy[i].length; j++) {
        possibilitys *= 6;
        if (i < 10) {
          goodPossibilitys *= 3;
        } else if (checkDices.listy[i].length == 5 || i == 10) {
          goodPossibilitys = 1;
        } else {
          goodPossibilitys = 6;
        }
      }
      Figure f = Figure((goodPossibilitys / possibilitys) * 100,
          figuresDictionary.elementAt(i), diceCount);
      figures.add(f);
    }
    figures.sort((a, b) => b.percent.compareTo(a.percent));
    scoreService.figureName = figures.first.name;
    scoreService.value = figures.first.count;
  }
}
