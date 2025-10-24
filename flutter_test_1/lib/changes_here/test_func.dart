/*
I set it up so all you have to focus on is the `changes_here` folder.
You can create new functions, classes, and even files to the folder.
If you're using multiple files, make sure they import each other.
Send me a message if you get lost.
*/

import 'package:flutter/material.dart';
import 'MorseMessage.dart';

void testFunc(TextEditingController textController, String? inputText) {
  // This changes the text for the "Output Field".
  MorseMessage input =   MorseMessage.fac("encode", inputText);

  textController.text =  input.plaintext??'';// maybe change to !(SOlo si siempre tendra resultado)

  // Add your functionality here.
}
