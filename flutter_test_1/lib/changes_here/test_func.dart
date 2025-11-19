/*
I set it up so all you have to focus on is the `changes_here` folder.
You can create new functions, classes, and even files to the folder.
If you're using multiple files, make sure they import each other.
Send me a message if you get lost.
*/

import 'package:flutter/material.dart';
import 'package:flutter_test_1/changes_here/test_file.dart';
import 'MorseMessage.dart';
import 'ShiftMessage.dart';

// void testFunc(TextEditingController textController, String? inputText) {
void testFunc(TextEditingController textController, String inputText) {
  // This changes the text for the "Output Field".

  MorseMessage input = MorseMessage.fac("decode", inputText);
  input.decrypt();
  //input.displayData("decode")!     para el textcontroller para tester morse code

  // ShiftMessage input = ShiftMessage.fac("encode", inputText, 5);
  //input.encrypt();
  // input.displayData("encode")! para el texcontroller para test shift

  textController.text = input.displayData("decode")!;

  // textController.text =
  //     input.displayData("decode") ??
  ''; // maybe change to !(SOlo si siempre tendra resultado)input.displayData("encode")??''

  // Add your functionality here.
}
