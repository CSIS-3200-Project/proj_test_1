/*
I set it up so all you have to focus on is the `changes_here` folder.
You can create new functions, classes, and even files to the folder.
If you're using multiple files, make sure they import each other.
Send me a message if you get lost.
*/

import 'package:flutter/material.dart';
import 'CypherManager.dart';

// void testFunc(TextEditingController textController, String? inputText) {
void testFunc(TextEditingController textController, String inputText) {
  // This changes the text for the "Output Field".

  //MorseMessage input = MorseMessage.fac("decode", inputText);
  // input.decrypt();
  //input.displayData("decode")!     para el textcontroller para tester morse code

  // ShiftMessage input = ShiftMessage.fac("encode", inputText, 5);
  //input.encrypt();
  // input.displayData("encode")! para el texcontroller para test shift

  String modeChoice = "decode";
  // String modeChoice = "encode";

  // String cypherType = "shift Cypher";
  String cypherType = "Morse Code";

  int shiftCypher = 5;

  String output = CypherManager.flowControl(
    // "encode",
    modeChoice,
    cypherType,
    inputText,
    shiftCypher,
  );

  // String output = CypherManager.flowControl(
  //   // "encode",
  //   modeChoice,
  //   cypherType,
  //   inputText,
  //   shiftCypher,
  // );

  //input.displayData("decode")!
  textController.text = output;

  // textController.text =
  //     input.displayData("decode") ??
  ''; // maybe change to !(SOlo si siempre tendra resultado)input.displayData("encode")??''

  // Add your functionality here.
}
