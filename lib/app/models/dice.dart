import 'dart:math';

import 'package:dices/app/services/score_service.dart';
import 'package:get/get.dart';

class Dice {
  final scoreService = Get.find<ScoreService>();
  RxInt count = 1.obs;
  int number = 1;
  int position;
  Dice(this.position);

  Future<void> rollNumber() async {
    for (int i = 0; i < 20; i++) {
      number = Random().nextInt(6) + 1;
      count.value = number;
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }
}
