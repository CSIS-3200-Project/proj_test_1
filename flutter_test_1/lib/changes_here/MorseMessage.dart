//import 'dart:ffi';

import 'package:characters/characters.dart';
import 'package:flutter/cupertino.dart';
import 'Message.dart';

class MorseMessage extends Message{
  List<String> splitedMessage = [];


static const morseTable = {
     'A':'.-',
     'B':'-...',
     'C':'-.-.',
     'D':'-..',
     'E':'.',
     'F':'..-.',
     'G':'--.',
     'H':'....',
     'I':'..',
     'J':'.---',
     'K':'-.-',
     'L':'.-..',
     'M':'--',
     'N':'-.',
     'O':'---',
     'P':'.--.',
     'Q':'--.-',
     'R':'.-.',
     'S':'...',
     'T':'-',
     'U':'..-',
     'V':'...-',
     'W':'.--',
     'X':'-..-',
     'Y':'-.--',
     'Z':'--..',

     ' ':'/',

     '1':'.----',
     '2':'..---',
     '3':'...--',
     '4':'....-',
     '5':'.....',
     '6':'-....',
     '7':'--...',
     '8':'---..',
     '9':'----.',
     '0':'-----',
};  

//================CONSTRUCTORS===================================================================================================
MorseMessage.empty();

MorseMessage.plaintext(String? message) :super.plaintext(plaintext: message) {
  splitedMessage = breakMessage();
}

MorseMessage.cyphertext(String? message) :super.cyphertext(cyphertext: message) {
  splitedMessage = breakMessage();
}

factory MorseMessage.fac(String state, String? message) {
  if(state == "encode") {
    return MorseMessage.plaintext(message);
  }
  else if (state == "decode") {
    return MorseMessage.cyphertext(message);
  }

  return MorseMessage.empty();
}
//=============METHODS========================================================================================================================
  @override
  void decrypt() {
    
    var decoded = StringBuffer();

    for(int index = 0; index < splitedMessage.length -1; index++) {
      morseTable.forEach((key, value) {
        if(splitedMessage[index] == value) {
          decoded.write(key);
        }
      });
    }

    plaintext = decoded.toString();
  }

  @override
  void encrypt() {
    var endecoded = StringBuffer();

    for(int index = 0; index < splitedMessage.length -1; index++) {
      morseTable.forEach((key, value) {
        if(splitedMessage[index] == key) {
          endecoded.write(key);
        }
      });    
    }

    cyphertext = endecoded.toString();
  }
  @override
  void setKey() {} // POssible deletion from Parent class
//=======SPLITING METHODS=============================================================================================

   List<String> breakMessage() { //general function that englove both 
      
    if(plaintext == null) {
     return splitCyphertext();
    }
    else if (cyphertext == null) {
      return splitPlaintext();
    }
    List<String> message = [];
    return message;
  }
   
    List<String> splitPlaintext() {
    return plaintext?.characters.toList() ?? [];
  }
   List<String> splitCyphertext() {
      return cyphertext?.split(RegExp(r'/')) ?? [];
     
  }
}