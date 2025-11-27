import 'message.dart';

class ShiftMessage extends Message {
  List<String> splitMessage = [];
  List<int> unicodeMessage = [];
  int shift = 0;

  static const String alphabet = "abcdefghijklmnopqrstuvwxyz";

  //===================CONSTRUCTORS=========================================
  ShiftMessage.empty();

  ShiftMessage.plaintext(String? message, int shift)
    : super.plaintext(plaintext: message) {
    splitMessage = breakMessage();
    this.shift = shift % alphabet.length;
  }

  ShiftMessage.cyphertext(String? message, int shift)
    : super.cyphertext(cyphertext: message) {
    splitMessage = breakMessage();
    this.shift = shift % alphabet.length;
  }

  factory ShiftMessage.fac(String state, String? message, int shift) {
    if (state == "encode") {
      return ShiftMessage.plaintext(message, shift);
    } else if (state == "decode") {
      return ShiftMessage.cyphertext(message, shift);
    }

    return ShiftMessage.empty();
  }

  @override
  void encrypt() {
    unicodeMessage = convertToNums(splitMessage);
    shiftText(shift);

    cyphertext = convertToText(unicodeMessage).join('');
  }

  @override
  void decrypt() {
    unicodeMessage = convertToNums(splitMessage);
    shiftText(-shift);

    plaintext = convertToText(unicodeMessage).join('');
  }

  @override
  void setKey() {}

  //===============SPLLIT METHODS============================================================
  List<String> breakMessage() {
    //general function that englove both
    if (plaintext != null) {
      return plaintext!.split('');
    } else if (cyphertext != null) {
      return cyphertext!.split('');
    }
    return [];
  }

  List<String> convertToText(List<int> messageInUnicode) {
    List<String> unicodeToText = [];
    for (int index = 0; index < messageInUnicode!.length; index++) {
      if (messageInUnicode[index] != -1) {
        unicodeToText.add(alphabet[messageInUnicode[index]]);
      } else {
        unicodeToText.add(" ");
      }
    }
    return unicodeToText;
  }

  List<int> convertToNums(List<String> message) {
    List<int> numList = [];
    for (int index = 0; index < message.length; index++) {
      if (message[index] != " ") {
        numList.add(alphabet.indexOf(message[index].toLowerCase()));
      } else {
        numList.add(-1);
      }
    }
    return numList;
  }

  void shiftText(int shift) {
    for (int index = 0; index < unicodeMessage.length; index++) {
      if (unicodeMessage[index] != -1) {
        unicodeMessage[index] =
            (unicodeMessage[index] + shift) % alphabet.length;
        if (unicodeMessage[index] < 0) unicodeMessage[index] += alphabet.length;
      } else {
        continue;
      }
    }
  }

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
