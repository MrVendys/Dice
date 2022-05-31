// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dices/app/models/dice.dart';
import 'package:image/image.dart' as I;
import 'package:dices/app/services/score_service.dart';
import 'package:dices/app/shared/data/figures.dart';
import 'package:dices/app/shared/widgets/dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/player.dart';

class DicesController extends GetxController {
  final scoreService = Get.find<ScoreService>();

  RxList<Dice> dices = <Dice>[].obs;
  RxList<Dice> stoppedDices = <Dice>[].obs;

  RxBool get isRollDisabled => dices.isEmpty.obs;
  RxInt get numberOfRolls => scoreService.numberOfRolls.obs;

  TextEditingController figureValueController = TextEditingController();

  RxInt get currentPlayer => scoreService.currentPlayer;

  Player? playingPlayer;

  int numberOnDice = 0;
  int numberOfScan = 0;

  AssetImage? image;
  RxDouble dotCount = 0.0.obs;
  @override
  void onInit() {
    playingPlayer = scoreService.players[currentPlayer.value];
    dices = scoreService.rolledDices;
    stoppedDices = scoreService.stoppedDices;
    if (!scoreService.hasFirstRolled) {
      fillDices();
      scoreService.hasFirstRolled = true;
    }

    super.onInit();
  }

  @override //
  void onReady() {} //
  @override
  void onClose() {
    scoreService.stoppedDices = stoppedDices;
  }

  void roll() {
    //
    if (numberOfRolls == 0.obs && playingPlayer!.records[18].value != 0) {
      scoreService.numberOfRolls++;
      playingPlayer!.records[18].value--;
    }

    for (var d in dices) {
      //
      d.rollNumber(); //
    } //

    scoreService.rolledDices = dices;
  }

  Future<void> addDices() async {}

  removeDice(int index) {
    stoppedDices.add(dices[index]);
    dices.removeAt(index);
    scoreService.rolledDices = dices;
  }

  updateDices() {
    Dice d = Dice(numberOfScan);
    d.count = numberOnDice.obs;
    d.number = numberOnDice;
    dices[numberOfScan] = d;
    scoreService.rolledDices = dices;
    numberOfScan == 5 ? numberOfScan = 0 : numberOfScan++;
  }

  fillDices() {
    dices.value = [];
    scoreService.rolledDices.value = [];
    for (var i = 0; i < 6; i++) {
      dices.add(Dice(i));
    }
    scoreService.rolledDices = dices;
  }

  nextPlayer() {
    //playingPlayer!.records[18].value += scoreService.numberOfRolls;
    scoreService.players[scoreService.currentPlayer.value].records[18].value += scoreService.numberOfRolls;
    scoreService.currentPlayer.value++;
    if (currentPlayer.value >= scoreService.players.length) {
      currentPlayer.value = 0;
    }
    scoreService.numberOfRolls = 3;
    reset();
  }

  void reset() {
    stoppedDices.value = [];
    fillDices();
  }

  void scan() async {
    dotCount = 0.0.obs;
    final tempImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (tempImage == null) return;

    image = AssetImage(tempImage.path);

    int color1 = 0;
    int color2 = 0;

    I.Image? img = I.decodeImage(File(tempImage.path).readAsBytesSync());

    for (var i = 0; i < img!.width; i++) {
      for (var j = 0; j < img.height; j++) {
        int pixel = img.getPixelSafe(i, j);
        Color pixelColor = getFlutterColor(pixel);
        //kontrolování žluté
        if ((pixelColor.blue > 0 && pixelColor.blue < 70) &&
            (pixelColor.red > 150 && pixelColor.red < 240) &&
            (pixelColor.green > 100 && pixelColor.green < 220)) {
          color1++;
        }
        //kontrolování černé
        if (pixelColor.blue < 45 &&
            pixelColor.green < 45 &&
            pixelColor.red < 45) {
          color2++;
        }
      }
    }
    int wholeDice = color1 + color2;
    int color2Precent = ((color2 / wholeDice) * 100).toInt();

    if (color2Precent < 4) numberOnDice = 1;
    if (color2Precent > 3 && color2Precent < 7) numberOnDice = 2;
    if (color2Precent > 6 && color2Precent < 10) numberOnDice = 3;
    if (color2Precent > 9 && color2Precent < 16) numberOnDice = 4;
    if (color2Precent > 15 && color2Precent < 17) numberOnDice = 5;
    if (color2Precent > 16) numberOnDice = 6;
    print(color2Precent);
    print(numberOnDice);
    updateDices();
  }

  Color getFlutterColor(int abgr) {
    int argb = abgrToArgb(abgr);
    return Color(argb);
  }

  int abgrToArgb(int argbColor) {
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }

  void showAddRecordDialog(
    BuildContext context,
  ) {
    RxString selectedFigure = figuresDictionary.first.obs;
    onSelectedFigureChanged(String figure) {
      selectedFigure(figure);
    }

    List<String> figures = figuresDictionary.getRange(0, 18).toList();
    Get.dialog(
      AlertDialog(
        title: Text('Add record'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => DropDownButton<String>(
                items: figures
                    .map(
                      (figure) => DropdownMenuItem<String>(
                        child: Text(figure),
                        value: figure,
                      ),
                    )
                    .toList(),
                onValueChanged: (figure) => onSelectedFigureChanged(figure),
                value: selectedFigure.value,
              ),
            ),
            TextField(
              controller: figureValueController,
            )
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => {
              scoreService.changeRecord(
                  selectedFigure.value, figureValueController.text),
              Get.back(),
              nextPlayer(),
            },
            child: Text('Ok'),
            style: ElevatedButton.styleFrom(primary: Colors.green),
          )
        ],
      ),
    );
  }
}
