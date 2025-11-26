/*
I set it up so all you have to focus on is the `changes_here` folder.
You can create new functions, classes, and even files to the folder.
If you're using multiple files, make sure they import each other.
Send me a message if you get lost.
*/

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'CypherManager.dart';

void testFunc(
  TextEditingController textController,
  String inputText,
  String inputLang,
  String outputLang,
) {
  // Setting string variables to mitigate issues with any misspelling of string.
  String encodeStr = "encode";
  String decodeStr = "decode";
  String plainTextStr = "plain text";
  String shiftCypherStr = "shift Cypher";
  String morseCodeStr = "Morse Code";

  String modeChoice = "";
  String cypherType = "";
  int shiftCypher = 5;

  if (equalsIgnoreAsciiCase(inputLang, outputLang)) {
    textController.text = inputText;
    return;
  }

  if (equalsIgnoreAsciiCase(inputLang, plainTextStr)) {
    modeChoice = encodeStr;

    if (equalsIgnoreAsciiCase(outputLang, morseCodeStr)) {
      cypherType = morseCodeStr;
    } else {
      cypherType = shiftCypherStr;
    }
  } else if (equalsIgnoreAsciiCase(inputLang, morseCodeStr)) {
    if (equalsIgnoreAsciiCase(outputLang, plainTextStr)) {
      modeChoice = decodeStr;
      cypherType = morseCodeStr;
    } else {
      modeChoice = encodeStr;
      cypherType = shiftCypherStr;
    }
  } else {
    if (equalsIgnoreAsciiCase(outputLang, plainTextStr)) {
      modeChoice = decodeStr;
      cypherType = shiftCypherStr;
    } else {
      modeChoice = encodeStr;
      cypherType = morseCodeStr;
    }
  }

  String output = "";

  output = CypherManager.flowControl(
    modeChoice,
    cypherType,
    inputText,
    shiftCypher,
  );

  textController.text = output;
}
