import 'package:flutter_test_1/changes_here/Message.dart';

import 'MorseMessage.dart';
import 'ShiftMessage.dart';

class CypherManager {
  CypherManager._();

  void flowControl(String state, String tecnique, String input, int shift) {
    switch (tecnique) {
      case "shift Cypher":
        ShiftMessage message = ShiftMessage.fac(state, input, shift);
        break;
      case "Morse Code":
        MorseMessage message = MorseMessage.fac(state, input);
        break;
    }

    switch (state) {
      case "encode":
        message.encrypt();
      case "decode":
    }
  }
}
