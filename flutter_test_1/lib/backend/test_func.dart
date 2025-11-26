/*
I set it up so all you have to focus on is the `changes_here` folder.
You can create new functions, classes, and even files to the folder.
If you're using multiple files, make sure they import each other.
Send me a message if you get lost.
*/

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'CypherManager.dart';

// void testFunc(TextEditingController textController, String? inputText) {
void testFunc(
  TextEditingController textController,
  String inputText,
  String inputLang,
  String outputLang,
) {
  // This changes the text for the "Output Field".

  print(inputLang);
  print(outputLang);

  String encodeStr = "encode";
  String decodeStr = "decode";
  String plainTextStr = "plain text";
  String shiftCypherStr = "shift Cypher";
  String morseCodeStr = "Morse Code";

  // String modeChoice = "decode";
  String modeChoice = "";
  String cypherType = "";
  String output = "";

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

  // outputLang = Plain Text
  // if (equalsIgnoreAsciiCase(outputLang, plainTextStr)) {
  //   modeChoice = decodeStr;
  //   if (equalsIgnoreAsciiCase(inputLang, morseCodeStr)) {
  //     cypherType = morseCodeStr;
  //   } else {
  //     cypherType = shiftCypherStr;
  //   }
  // } else {
  //   modeChoice = encodeStr;

  //   // outputLang = Morse Code
  //   if (equalsIgnoreAsciiCase(outputLang, morseCodeStr)) {
  //     if (equalsIgnoreAsciiCase(inputLang, plainTextStr)) {
  //       cypherType = morseCodeStr;
  //     } else {
  //       cypherType = shiftCypherStr;
  //     }
  //   }
  //   // outputLang = Shift Cypher
  //   else {
  //     if (equalsIgnoreAsciiCase(inputLang, plainTextStr)){
  //       cypherType =
  //     }
  //   }
  // }

  // if (equalsIgnoreAsciiCase(outputLang, ))

  int shiftCypher = 5;

  output = CypherManager.flowControl(
    // "encode",
    modeChoice,
    cypherType,
    inputText,
    shiftCypher,
  );

  //input.displayData("decode")!
  textController.text = output;
}
