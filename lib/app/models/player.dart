import 'package:dices/app/models/record.dart';
import 'package:dices/app/shared/data/figures.dart';
import 'package:get/get.dart';

class Player {
  String name;
  RxList<Record> records = <Record>[].obs;

  Player(this.name) {
    for (final figure in figuresDictionary) {
      records.add(Record(figure, 0));
    }
  }

  addRecord(int record, int position) {
    records[position].value = record;
  }

  sumRecords() {
    int count = 0;
    for(int i = 0; i < 18; i++){
      count += records[i].value;
    }
    records[19].value = count;
  }
}
