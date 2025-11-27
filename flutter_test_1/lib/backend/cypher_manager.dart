import 'crypto_library.dart';

class CypherManager {
  CypherManager._();

  static String flowControl(
    String state,
    String technique,
    String input,
    int shift,
  ) {
    Message? cypher;
    switch (technique) {
      case "shift Cypher":
        cypher = ShiftMessage.fac(state, input, shift);
        break;
      case "Morse Code":
        cypher = MorseMessage.fac(state, input);
        break;
      default:
        throw Exception("Unknown Techinque");
    }

    switch (state) {
      case "encode":
        cypher.encrypt();
        break;
      case "decode":
        cypher.decrypt();
        break;
      default:
        throw Exception("Unknown State");
    }

    return cypher.displayData(state)!;
  }
}
