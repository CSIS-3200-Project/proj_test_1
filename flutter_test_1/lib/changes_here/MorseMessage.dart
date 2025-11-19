//import 'dart:ffi';

// import 'package:characters/characters.dart';
import 'package:flutter/cupertino.dart';
import 'Message.dart';

class MorseMessage extends Message {
  List<String> splitedMessage = [];

  static const morseTable = {
    'A': '.-',
    'B': '-...',
    'C': '-.-.',
    'D': '-..',
    'E': '.',
    'F': '..-.',
    'G': '--.',
    'H': '....',
    'I': '..',
    'J': '.---',
    'K': '-.-',
    'L': '.-..',
    'M': '--',
    'N': '-.',
    'O': '---',
    'P': '.--.',
    'Q': '--.-',
    'R': '.-.',
    'S': '...',
    'T': '-',
    'U': '..-',
    'V': '...-',
    'W': '.--',
    'X': '-..-',
    'Y': '-.--',
    'Z': '--..',

    ' ': '/',

    '1': '.----',
    '2': '..---',
    '3': '...--',
    '4': '....-',
    '5': '.....',
    '6': '-....',
    '7': '--...',
    '8': '---..',
    '9': '----.',
    '0': '-----',
  };

  //================CONSTRUCTORS===================================================================================================
  MorseMessage.empty();

  MorseMessage.plaintext(String? message)
    : super.plaintext(plaintext: message) {
    splitedMessage = breakMessage();
  }

  MorseMessage.cyphertext(String? message)
    : super.cyphertext(cyphertext: message) {
    splitedMessage = breakMessage();
  }

  factory MorseMessage.fac(String state, String? message) {
    if (state == "encode") {
      return MorseMessage.plaintext(message);
    } else if (state == "decode") {
      return MorseMessage.cyphertext(message);
    }

    return MorseMessage.empty();
  }
  //=============METHODS========================================================================================================================
  @override
  void decrypt() {
    var decoded = StringBuffer();

    splitedMessage.forEach((symbol) {
      bool found = false;

      for (var entry in morseTable.entries) {
        if (entry.value == symbol) {
          decoded.write(entry.key + " ");
          found = true;
          break;
        }
      }

      if (!found) {
        decoded.write("?");
      }
    });

    plaintext = decoded.toString();
  }

  @override
  void encrypt() {
    var endecoded = StringBuffer();

    splitedMessage.forEach((letter) {
      bool found = false;

      for (var entry in morseTable.entries) {
        if (entry.key == letter) {
          endecoded.write(entry.value + " ");
          found = true;
          break;
        }
      }
      if (!found) endecoded.write("?");
    });

    cyphertext = endecoded.toString().trim();
  }

  @override
  void setKey() {} // POssible deletion from Parent class
  //=======SPLITING METHODS=============================================================================================

  List<String> breakMessage() {
    //general function that englove both

    if (plaintext != null) {
      return splitPlaintext();
    } else if (cyphertext != null) {
      return splitCyphertext();
    }
    List<String> message = [];
    return message;
  }

  List<String> splitPlaintext() {
    return plaintext?.toUpperCase().characters.toList() ?? [];
  }

  List<String> splitCyphertext() {
    return cyphertext?.trim().split(" ").where((s) => s.isNotEmpty).toList() ??
        [];
  }

  // hhhhhhhhhh
  String? displayData(String mode) {
    // mode = encode || decode
    String? output = "ningun if statement fue ejecutado";
    if (mode.compareTo("decode") == 0) {
      return plaintext;
    }
    if (mode.compareTo("encode") == 0) {
      return cyphertext;
    }
    return output;
  }
}
