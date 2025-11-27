import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'cypher_manager.dart';

void cypherFuncCall(
  TextEditingController textController,
  String inputText,
  String inputLang,
  String outputLang,
  int shiftCypher,
) {
  // Setting string variables to mitigate issues with any misspelling of string.
  String encodeStr = "encode";
  String decodeStr = "decode";
  String plainTextStr = "plain text";
  String shiftCypherStr = "shift Cypher";
  String morseCodeStr = "Morse Code";

  String modeChoice = "";
  String cypherType = "";

  // Using equalsIgnoreAsciiCase to avoid issues with upper and lower case.
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
