// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:dices/app/modules/dices/views/widgets/rolled_dice.dart';
import 'package:dices/app/modules/helper/widgets/custom_data_text.dart';
import 'package:dices/app/shared/widgets/layout/custom_layout.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/helper_controller.dart';

class HelperView extends GetView<HelperController> {
  const HelperView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      title: 'Helper',
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Rolled dices:',
                      style: TextStyle(fontSize: 40.0),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...controller.rolledDices
                            .where((x) => x.position < 3)
                            .map((t) {
                          return RolledDice(
                            count: t.count.value,
                            onTap: () => {},
                          );
                        }).toList(),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...controller.rolledDices
                            .where((x) => x.position > 2)
                            .map((t) {
                          return RolledDice(
                            count: t.count.value,
                            onTap: () => {},
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: SizedBox(
                height: 250,
                width: 450,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDataText(
                        text:
                            "${controller.figures[0].name.toString()} ${controller.figures[0].count.toString()}+ ${controller.figures[0].percent.toInt()}%"),
                    CustomDataText(
                        text:
                            "${controller.figures[1].name.toString()} ${controller.figures[1].count.toString()}+ ${controller.figures[1].percent.toInt()}%"),
                    CustomDataText(
                        text:
                            "${controller.figures[2].name.toString()} ${controller.figures[2].count.toString()}+ ${controller.figures[2].percent.toInt()}%"),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
