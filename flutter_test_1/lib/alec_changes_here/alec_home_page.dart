import 'package:flutter/material.dart';
import 'dart:math' as math;

Widget alecHomePage() {
  return Scaffold(
    backgroundColor: const Color(0xFF15202B),
    body: Center(
      child: Container(
        width: 393,
        height: 852,
        decoration: const BoxDecoration(color: Color(0xFF15202B)),
        child: _NovaCryptUI(),
      ),
    ),
  );
}

class _NovaCryptUI extends StatefulWidget {
  @override
  State<_NovaCryptUI> createState() => _NovaCryptUIState();
}

class _NovaCryptUIState extends State<_NovaCryptUI> {
  final TextEditingController inputController = TextEditingController();
  String outputText = '';
  bool showAboutCard = false;
  String selectedInputLanguage = 'Plain Text'; // default
  String selectedOutputLanguage = 'Plain Text'; // default

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
            title: const Text('Plain Text', style: TextStyle(color: Colors.white)),
            onTap: () {
              onSelected('Plain Text');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('AES-256', style: TextStyle(color: Colors.white)),
            onTap: () {
              onSelected('AES-256');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Ceasar', style: TextStyle(color: Colors.white)),
            onTap: () {
              onSelected('Ceasar');
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
        // Only show main UI if About card is NOT visible
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
                  controller: inputController,
                  onChanged: (text) => setState(() => outputText = text),
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
                  child: Text(
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

          // Bottom bar
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
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
  onPressed: () => showLanguageModal((selected) {
    setState(() {
      selectedInputLanguage = selected;
    });
  }),
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF15202B),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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

ElevatedButton(
  onPressed: () => showLanguageModal((selected) {
    setState(() {
      selectedOutputLanguage = selected;
    });
  }),
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF15202B),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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

                  ],
                ),
              ),
            ),
          ),
        ],

        // About card overlay
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
                            text: 'Project Lead\nHelmi Hernandez\n\n'
                                'Back-End\nJuan Dominguez\n\n'
                                'Front-End\nAlec Valdes\n\n'
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
