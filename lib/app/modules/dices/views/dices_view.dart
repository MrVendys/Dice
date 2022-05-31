// ignore_for_file: prefer_const_constructors

import 'package:dices/app/modules/dices/views/widgets/rolled_dice.dart';
import 'package:dices/app/shared/widgets/layout/custom_layout.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dices_controller.dart';

class DicesView extends GetView<DicesController> {
  DicesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      title: 'Dices',
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Current player: ${controller.scoreService.players[controller.scoreService.currentPlayer.toInt()].name}',
                      style: TextStyle(fontSize: 28.0),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Available  dices:',
                    style: TextStyle(fontSize: 40.0),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...controller.dices.where((x) => x.position < 3).map((t) {
                        int index = controller.dices.indexOf(t);
                        return RolledDice(
                          count: t.count.value,
                          onTap: () => controller.removeDice(index),
                        );
                      }).toList(),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...controller.dices.where((x) => x.position > 2).map((t) {
                        int index = controller.dices.indexOf(t);
                        return RolledDice(
                          count: t.count.value,
                          onTap: () => controller.removeDice(index),
                        );
                      }).toList(),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Stopped dices:',
                    style: TextStyle(fontSize: 40.0),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...controller.stoppedDices
                          .where((x) => controller.stoppedDices.indexOf(x) < 3)
                          .map(
                            (d) => RolledDice(count: d.count.value),
                          )
                          .toList(),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...controller.stoppedDices
                          .where((x) => controller.stoppedDices.indexOf(x) > 2)
                          .map(
                            (d) => RolledDice(count: d.count.value),
                          )
                          .toList(),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => ElevatedButton(
                    onPressed: () {
                      if (controller.isRollDisabled.value ||
                          controller.numberOfRolls == 0.obs) {
                        return;
                      }
                      controller.scoreService.numberOfRolls--;
                      controller.roll();
                      
                    },
                    child: Text('ROLL!'),
                    style: ElevatedButton.styleFrom(
                      primary: controller.isRollDisabled.value
                          ? Colors.grey
                          : Colors.green,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                ElevatedButton(
                  onPressed: () => controller.reset(),
                  child: Text('RESET!'),
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                controller.scan();
              },
              child: Text('SCAN DICE'),
              style: ElevatedButton.styleFrom(primary: Colors.green),
            ),
            ElevatedButton(
              onPressed: () {
                controller.showAddRecordDialog(context);
              },
              child: Text('ADD RECORD'),
              style: ElevatedButton.styleFrom(primary: Colors.green),
            ),
            ElevatedButton(
              onPressed: () {
                controller.nextPlayer();
              },
              child: Text('END TURN'),
              style: ElevatedButton.styleFrom(primary: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
