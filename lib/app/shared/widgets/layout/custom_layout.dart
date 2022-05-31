// ignore_for_file: prefer_const_constructors

import 'package:dices/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLayout extends StatelessWidget {
  final Widget child;
  final String title;

  const CustomLayout({
    Key? key,
    required this.child,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () => showHelpDialog(context),
              icon: Icon(Icons.help_outline))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow_rounded),
        backgroundColor: Colors.green,
        onPressed: () => Get.offNamed(Routes.DICES),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 56,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.table_chart),
                  onPressed: () => Get.offNamed(Routes.HOME),
                ),
              ),
              Expanded(
                child: IconButton(
                    icon: const Icon(Icons.stacked_bar_chart),
                    onPressed: () => Get.offNamed(Routes.HELPER)),
              ),
            ],
          ),
        ),
      ),
      body: child,
    );
  }

  void showHelpDialog(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('How to play'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                    "Ve svém tahu hráč hodí se 6 kostkami. Padnou-li kostky, ze kterých by šlo poskládat nějakou figuru, tak si je hráč odloží a hází se zbylíma. Pokud po 3. hodu nedokáže hráč ze svých kostek nic poskládat a nechce si čerpat dobra, tak je na tahu další hráč. V opačném případě si spočítá body na kostkách a zapíše si je pod určitou figuru v tabulce"),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Get.back(),
                child: Text('Back'),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              )
            ],
            scrollable: true,
          );
        });
  }
}
