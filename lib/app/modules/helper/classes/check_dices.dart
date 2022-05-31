class CheckDices {
  List<int> listOfDiceNumbers = [];
  List<int> jednicky = [];
  List<int> dvojky = [];
  List<int> trojky = [];
  List<int> ctyrky = [];
  List<int> petky = [];
  List<int> sestky = [];
  List<int> male = [];
  List<int> velke = [];
  List<int> sude = [];
  List<int> liche = [];
  List<int> rada = [];
  List<int> dvojice = [];
  List<int> trojice = [];
  List<int> ctyriPlusDva = [];
  List<int> petPlusJedna = [];
  List<int> pyramida = [];
  List<int> vrhcab = [];
  List<int> general = [];
  List<List<int>> listy = [];

  CheckDices(this.listOfDiceNumbers) {
    listy.add(jednicky);
    listy.add(dvojky);
    listy.add(trojky);
    listy.add(ctyrky);
    listy.add(petky);
    listy.add(sestky);
    listy.add(male);
    listy.add(velke);
    listy.add(sude);
    listy.add(liche);
    listy.add(rada);
    listy.add(dvojice);
    listy.add(trojice);
    listy.add(ctyriPlusDva);
    listy.add(petPlusJedna);
    listy.add(pyramida);
    listy.add(vrhcab);
    listy.add(general);
    doCheck();
  }
  doCheck() {
    List<int> listOfNumbers = [0, 0, 0, 0, 0, 0];
    for (int i in listOfDiceNumbers) {
      for (var j = 1; j < 7; j++) {
        if (i == j) {
          listOfNumbers[j - 1]++;
        }
      }
      if (i == 1) {
        //jednicky
        listy[0].add(i);
        if (!listy[10].contains(i)) {
          //rada
          listy[10].add(i);
        }
      }
      if (i == 2) {
        //dvojky
        listy[1].add(i);
        if (!listy[10].contains(i)) {
          //rada
          listy[10].add(i);
        }
      }
      if (i == 3) {
        listy[2].add(i);
        if (!listy[10].contains(i)) {
          listy[10].add(i);
        }
      }
      if (i == 4) {
        listy[3].add(i);
        if (!listy[10].contains(i)) {
          listy[10].add(i);
        }
      }
      if (i == 5) {
        listy[4].add(i);
        if (!listy[10].contains(i)) {
          listy[10].add(i);
        }
      }
      if (i == 6) {
        listy[5].add(i); //sestky
        listy[17].add(i);
        if ((!listy[10].contains(i)) == true) {
          listy[10].add(i); //rada
        }
      }
      if (i < 4) {
        //male
        listy[6].add(i);
      }
      if (i > 3) {
        //velke
        listy[7].add(i);
      }
      if (i % 2 == 0) {
        //duce
        listy[8].add(i);
      }
      if (i % 2 == 1) {
        //liche
        listy[9].add(i);
      }
    }
    for (var i = 0; i < listOfNumbers.length; i++) {
      
      if (listOfNumbers[i] == 2) {
        //dvojce
        doAdd(11, 2, i + 1);
      }
      if ((listOfNumbers[i] == 2 && listOfNumbers.contains(3))) {
        // dvojce do trojic
        doAdd(12, 2, i + 1);
        if ((listOfNumbers.indexOf(3) > listOfNumbers.indexOf(i)) &&
            listOfNumbers.indexOf(3) > 2) {
          //pyramida
          doAdd(15, 2, i + 1);
          doAdd(15, 3, listOfNumbers.indexOf(3) + 1);
          doAdd(15, 1, listOfNumbers.indexOf(1) + 1);
        } else if ((listOfNumbers.indexOf(3) < listOfNumbers.indexOf(i)) &&
            listOfNumbers.indexOf(3) < 5) {
          //vrhcáb
          doAdd(16, 2, i + 1);
          doAdd(16, 3, listOfNumbers.indexOf(3) + 1);
          doAdd(15, 1, listOfNumbers.indexOf(1) + 1);
        }
      }
      if (listOfNumbers[i] == 2 && listOfNumbers.contains(4)) {
        //dvojce do 4+2
        doAdd(13, 2, i + 1);
      }
      if (listOfNumbers[i] == 3) {
        //trojce
        doAdd(12, 3, i + 1);
      }
      if (listOfNumbers[i] == 4) {
        //4+2
        doAdd(13, 4, i + 1);
      }

      if (listOfNumbers[i] == 5) {
        //5+1
        doAdd(14, 5, i + 1);
        if (listOfNumbers.contains(1)) {
          doAdd(14, 1, listOfNumbers.indexOf(1));
        }
      }
    }
  }

  doAdd(int position, int count, int number) {
    for (var i = 0; i < count; i++) {
      listy[position].add(number);
    }
  }
}
