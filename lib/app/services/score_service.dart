import 'package:dices/app/models/dice.dart';
import 'package:dices/app/models/player.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ScoreService {
  RxList<Dice> rolledDices = <Dice>[].obs;
  RxList<Dice> stoppedDices = <Dice>[].obs;
  RxList<Player> players = <Player>[
    Player("Venca"),
    Player("Petr"),
  ].obs;

  bool hasFirstRolled = false;
  int value = 1;
  String figureName = "1";
  RxInt currentPlayer = 0.obs;
  bool doAddRecord = false;
  int numberOfRolls = 3;

  changeRecord(String figureToChange, String value) {
    if (value != "") {
      players[currentPlayer.value]
          .records
          .firstWhere((record) => record.figure == figureToChange)
          .value = int.parse(value);
      bool hasEverything = false;
      for (var value in players[currentPlayer.value].records.value) {
        if (value != 0) {
          hasEverything = true;
        }
      }
      if (hasEverything) {
        for (Player p in players) {
          p.sumRecords();
        }
      }
    }
  }
}
