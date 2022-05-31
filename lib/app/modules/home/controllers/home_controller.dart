// ignore_for_file: unnecessary_overrides

import 'package:dices/app/models/player.dart';
import 'package:dices/app/services/score_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final scoreService = Get.find<ScoreService>();

  List<Player> get players => scoreService.players;
  TextEditingController nameController = TextEditingController();

  
  @override
  void onInit() {
    if (scoreService.doAddRecord) {
      addRecord();
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void addRecord() {
  }
}
