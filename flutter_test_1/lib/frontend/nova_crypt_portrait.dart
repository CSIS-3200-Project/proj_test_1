import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_1/backend/test_func.dart';

Widget novacryptPortraitUI() {
  return Scaffold(
    backgroundColor: const Color(0xFF15202B),
    body: Center(
      child: Container(
        width: 393,
        height: 852,
        decoration: const BoxDecoration(color: Color(0xFF15202B)),
        child: _NovaCryptPortraitUI(),
      ),
    ),
  );
}

class _NovaCryptPortraitUI extends StatefulWidget {
  @override
  State<_NovaCryptPortraitUI> createState() => _NovaCryptPortraitUIState();
}

class _NovaCryptPortraitUIState extends State<_NovaCryptPortraitUI> {
  TextEditingController inputController = TextEditingController();
  TextEditingController shiftController = TextEditingController();
  int shiftInput = 0;
  String outputText = '';
  final List logList = <String>[];
  bool showAboutCard = false;

  String selectedInputLanguage = 'Plain Text';
  String selectedOutputLanguage = 'Morse Code';

  @override
  void initState() {
    super.initState();
    inputController.text = "Input Goes Here";
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  void callTestFunc(String value) {
    testFunc(
      inputController,
      value,
      selectedInputLanguage,
      selectedOutputLanguage,
      shiftInput,
    );
    outputText = inputController.text;
    (outputText.isEmpty || outputText.contains('?'))
        ? null
        : logList.add(outputText);
  }

  void checkShiftValid() {
    var intParse = int.tryParse(shiftController.text);

    if (intParse != null) {
      shiftInput = intParse;
    } else {
      shiftController.text = shiftInput.toString();
    }
  }

  /*
   selectedInputLanguage options
   'Plain Text'
   'Morse Code'
   'Shift Cypher'
  */
  void swapLanguages() {
    setState(() {
      var temp = selectedInputLanguage;
      selectedInputLanguage = selectedOutputLanguage;
      selectedOutputLanguage = temp;
    });
  }

  void _showSettingsModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF192734),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Shift Cypher & Logs',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Shift amount input
            ListTile(
              title: Row(
                children: [
                  const Text(
                    'Shift Amount:',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFieldTapRegion(
                      onTapOutside: (PointerDownEvent event) {
                        checkShiftValid();
                        FocusScope.of(context).unfocus();
                      },
                      child: TextField(
                        controller: shiftController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF22303C),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Logs section
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFF22303C),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  SelectableText(
                    logList.isEmpty
                        ? 'Previous messages will appear here'
                        : logList
                              .map((log) {
                                return log + '\n';
                              })
                              .join('')
                              .toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLanguageModal(Function(String) onSelected) {
    if (showAboutCard) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF192734),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Language',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text(
                'Plain Text',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                onSelected('Plain Text');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                'Morse Code',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                onSelected('Morse Code');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                'Shift Cipher',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                onSelected('Shift Cypher');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!showAboutCard) ...[
          // Menu Button
          Positioned(
            left: 20,
            top: 20,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showAboutCard = true;
                });
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: const ShapeDecoration(
                  color: Color(0xFF22303C),
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Container(
                          width: 30,
                          height: 3.75,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8899AC),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Title
          const Positioned(
            top: 90,
            left: 0,
            right: 0,
            child: Text(
              'NovaCrypt',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                letterSpacing: -2.0,
              ),
            ),
          ),

          // Input Box
          Positioned(
            left: 20,
            top: 200,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Opacity(
                  opacity: 0.5,
                  child: Text(
                    'Type Here',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  // controller: inputController,
                  // onChanged: (text) => setState(() => outputText = text),
                  onSubmitted: (value) async {
                    setState(() {
                      callTestFunc(value);
                    });
                  },
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF192734),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Enter text...',
                    hintStyle: const TextStyle(color: Color(0xFF8899AC)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: const Opacity(
                    opacity: 0.5,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Press Enter to receive output.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Output Box
          Positioned(
            left: 20,
            top: 400,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Opacity(
                  opacity: 0.5,
                  child: Text(
                    'Output',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF192734),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SelectableText(
                    outputText.isEmpty ? "..." : outputText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Settings Button
          Positioned(
            right: 20,
            bottom: 123, // same height as your language tab
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: _showSettingsModal, // your function to show the modal
                child: Container(
                  width: 96,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFF22303C), // button background
                    borderRadius: BorderRadius.circular(50), // rounded edges
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Settings/Log',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Bottom Bar
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: 393,
              height: 110,
              decoration: const BoxDecoration(
                color: Color(0xFF192734),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 158,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () => showLanguageModal((selected) {
                          setState(() {
                            selectedInputLanguage = selected;
                          });
                        }),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF15202B),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          selectedInputLanguage,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),

                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: swapLanguages,
                        child: SvgPicture.asset(
                          'assets/icons/swapLanguageButton.svg',
                          width: 17,
                          height: 17,
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 158,
                      height: 53,
                      child: ElevatedButton(
                        onPressed: () => showLanguageModal((selected) {
                          setState(() {
                            selectedOutputLanguage = selected;
                          });
                        }),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF15202B),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          selectedOutputLanguage,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],

        // About Card
        if (showAboutCard)
          Positioned.fill(
            child: GestureDetector(
              onTap: () => setState(() => showAboutCard = false),
              child: Container(
                color: Colors.black.withValues(alpha: 0.6),
                alignment: Alignment.center,
                child: Container(
                  width: 314,
                  height: 390,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF22303C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'About\n',
                            style: TextStyle(
                              color: Color(0xFF8899AC),
                              fontSize: 32,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(
                            text: 'Project Members\n\n',
                            style: TextStyle(
                              color: Color(0xFF8899AC),
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const TextSpan(
                            text:
                                'Project Lead\n'
                                'Helmi Hernandez\n\n'
                                'Back-End\n'
                                'Juan Dominguez\n\n'
                                'Front-End\n'
                                'Alec Valdes\n\n'
                                'Version 1.0.0',
                            style: TextStyle(
                              color: Color(0xFF8899AC),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
