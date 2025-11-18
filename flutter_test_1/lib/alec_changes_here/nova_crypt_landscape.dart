import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget novacryptLandscapeUI() {
  return Scaffold(
    backgroundColor: const Color(0xFF15202B),
    body: Center(
      child: Container(
        width: 1440,
        height: 1024,
        decoration: const BoxDecoration(color: Color(0xFF15202B)),
        child: _NovaCryptLandscapeUI(),
      ),
    ),
  );
}

class _NovaCryptLandscapeUI extends StatefulWidget {
  @override
  State<_NovaCryptLandscapeUI> createState() => _NovaCryptLandscapeUIState();
}

class _NovaCryptLandscapeUIState extends State<_NovaCryptLandscapeUI> {
  final TextEditingController inputController = TextEditingController();
  String outputText = '';
  bool showAboutCard = false;

  String selectedInputLanguage = 'Plain Text';
  String selectedOutputLanguage = 'Morse Code';

  void swapLanguages() {
    setState(() {
      final temp = selectedInputLanguage;
      selectedInputLanguage = selectedOutputLanguage;
      selectedOutputLanguage = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!showAboutCard)
          // Menu Button
          Positioned(
            right: 20,
            top: 20,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showAboutCard = true;
                });
              },
              child: Container(
                width: 64,
                height: 64,
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
                          width: 40,
                          height: 5,
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
            left: 35,
            top: 28,
            child: Text(
              'NovaCrypt',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                letterSpacing: -4.40,
              ),
            ),
          ),

          // Input Box
          Positioned(
            left: 20,
            top: 218,
            right: 740,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Opacity(
                  opacity: 0.5,
                  child: Text(
                    'Type Here',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 480, width: 680),
                TextField(
                  controller: inputController,
                  onChanged: (text) => setState(() => outputText = text),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF22303C),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Enter text...',
                    hintStyle: const TextStyle(color: Color(0xFF8899AC)),
                  ),
                )
              ],
            )
          )
      ],
    );
  }
}