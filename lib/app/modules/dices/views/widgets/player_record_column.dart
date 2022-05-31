// ignore_for_file: prefer_const_constructors

import 'package:dices/app/models/player.dart';
import 'package:dices/app/models/record.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerRecordColumn extends StatelessWidget {
  const PlayerRecordColumn({Key? key, required this.player}) : super(key: key);
  final Player player;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Text(
            player.name,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 20,
            width: 75,
          ),
          for (Record item in player.records)
            SizedBox(
              child: Text(
                item.value.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
              width: 75,
              height: 40,
            ),
        ],
      ),
    );
  }
}
