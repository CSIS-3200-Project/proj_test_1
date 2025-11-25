abstract class Message {
  String? plaintext;
  String? cyphertext;

  //========CONSTRUCTORS=======================================================================================================================
  Message();
  Message.plaintext({
    this.plaintext,
  }); // possibly add another paramter int const (int 0, int 1) for each case
  Message.cyphertext({this.cyphertext});

  //========Getters and Setters=================================================================================================================
  void setPlaintext(String plaintext) {
    this.plaintext = plaintext;
  }

  void setCyphertext(String cyphertext) {
    this.cyphertext = cyphertext;
  }

  String? getPlaintext() {
    return plaintext;
  }

  String? getCyphertext() {
    return cyphertext;
  }

  //======METHODS================================================================================================================================
  void encrypt();
  void decrypt();
  void setKey();
  String? displayData(String mode);
}
