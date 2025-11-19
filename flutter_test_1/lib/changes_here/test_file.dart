String testFile1(String input) {
  // print(testDic['A']);

  int countInternal = 0;
  int countExternal = 0;
  int countFound = 0;

  List<String> letras = ["A", "B", "C"];

  // String output = "";
  var output = StringBuffer();

  letras.forEach((testStr) {
    for (var entry in testDic.entries) {
      if (entry.value == testStr) {
        output.write(entry.key);
      }
    }

    print("inside the loop");
  });

  //print(output + "cadena completa");
  print(output.toString() + "string buffer completa!!");

  print(countInternal);
  print(countFound);
  print(countExternal);

  // String output = ;

  return input;
}

const testDic = {"A": "aaaa", "B": "bbbb", "C": 'cccc'};
