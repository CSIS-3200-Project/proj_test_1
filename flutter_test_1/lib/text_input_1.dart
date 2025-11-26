import 'package:flutter/material.dart';
import 'package:flutter_test_1/backend/test_func.dart';

class TextInput1 extends StatefulWidget {
  const TextInput1({super.key});

  @override
  State<TextInput1> createState() => _TextInput1State();
}

class _TextInput1State extends State<TextInput1> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = "Input Goes Here";
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Input Field",
              hintText: "Your input goes here.",
            ),
            onSubmitted: (value) async {
              setState(() {
                // testFunc(textController, value);
              });
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: TextField(
            controller: textController,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Output Field",
              hintText: """
THIS FIELD CANNOT BE EDITTED. It will only display the output from the input field.
When you hit `enter` in the input field, the output will be displayed here.""",
            ),
          ),
        ),
      ],
    );
  }
}
