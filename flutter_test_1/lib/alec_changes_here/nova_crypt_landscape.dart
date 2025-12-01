import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Fixed proportions: 1440 x 1024
const double baseWidth = 1440;
const double baseHeight = 1024;

Widget novacryptLandscapeUI() {
  return Scaffold(
    backgroundColor: const Color(0xFF15202B),
    body: LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        double sx(double x) => x * (w / baseWidth);
        double sy(double y) => y * (h / baseHeight);
        double sw(double width) => width * (w / baseWidth);
        double sh(double height) => height * (h / baseHeight);

        return _NovaCryptLandscapeUI(
          sx: sx,
          sy: sy,
          sw: sw,
          sh: sh,
        );
      },
    ),
  );
}

class _NovaCryptLandscapeUI extends StatefulWidget {
  final double Function(double) sx;
  final double Function(double) sy;
  final double Function(double) sw;
  final double Function(double) sh;

  const _NovaCryptLandscapeUI({
    required this.sx,
    required this.sy,
    required this.sw,
    required this.sh,
  });

  @override
  State<_NovaCryptLandscapeUI> createState() => _NovaCryptLandscapeUIState();
}

class _NovaCryptLandscapeUIState extends State<_NovaCryptLandscapeUI> {
  final TextEditingController inputController = TextEditingController();
  final TextEditingController shiftController = TextEditingController();

  String outputText = "";
  bool showSettings = true;
  bool showAboutCard = false;
  List<String> logs = [];

  String selectedInputLanguage = "Plain Text";
  String selectedOutputLanguage = "Morse Code";

  void swapLanguages() {
    setState(() {
      final temp = selectedInputLanguage;
      selectedInputLanguage = selectedOutputLanguage;
      selectedOutputLanguage = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sx = widget.sx;
    final sy = widget.sy;
    final sw = widget.sw;
    final sh = widget.sh;

    return Stack(
      children: [
        if (!showAboutCard) ...[
          
          // Title
          Positioned(
            left: sx(35),
            top: sy(28),
            child: Text(
              "NovaCrypt",
              style: TextStyle(
                color: Colors.white,
                fontSize: sh(40),
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
                letterSpacing: -2.0,
              ),
            ),
          ),

          // Burger button
          Positioned(
            right: sx(20),
            top: sy(20),
            child: GestureDetector(
              onTap: () => setState(() => showAboutCard = true),
              child: Container(
                width: sw(64),
                height: sh(64),
                decoration: const ShapeDecoration(
                  color: Color(0xFF22303C),
                  shape: OvalBorder(),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: sh(3)),
                        child: Container(
                          width: sw(40),
                          height: sh(5),
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

          // Input label
          Positioned(
            left: sx(20),
            top: sy(180),
            child: Text(
              "Type Here",
              style: TextStyle(
                color: Colors.white.withOpacity(.55),
                fontSize: sh(24),
              ),
            ),
          ),

          // Output label
          Positioned(
            left: sx(740),
            top: sy(180),
            child: Text(
              "Output",
              style: TextStyle(
                color: Colors.white.withOpacity(.55),
                fontSize: sh(24),
              ),
            ),
          ),

          // Input box
          Positioned(
            left: sx(20),
            top: sy(220),
            child: Container(
              width: sw(680),
              height: sh(480),
              decoration: BoxDecoration(
                color: const Color(0xFF22303C),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(sh(16)),
              child: TextField(
                controller: inputController,
                maxLines: null,
                onChanged: (t) => setState(() => outputText = t),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter text...",
                  hintStyle: TextStyle(color: Color(0xFF8899AC)),
                ),
              ),
            ),
          ),

          // Output box
          Positioned(
            left: sx(740),
            top: sy(220),
            child: Container(
              width: sw(680),
              height: sh(480),
              decoration: BoxDecoration(
                color: const Color(0xFF22303C),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(sh(16)),
              child: SingleChildScrollView(
                child: Text(
                  outputText,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),

          // Settings / Log tabs
          Positioned(
            left: sx(0),
            top: sy(718),
            child: Row(
              children: [
                _tabButton(
                  width: sw(200),
                  height: sh(50),
                  label: "Settings",
                  active: showSettings,
                  onTap: () => setState(() => showSettings = true),
                ),
                _tabButton(
                  width: sw(200),
                  height: sh(50),
                  label: "Log",
                  active: !showSettings,
                  onTap: () => setState(() => showSettings = false),
                ),
              ],
            ),
          ),

          // Tab content panel
          Positioned(
            left: sx(0),
            top: sy(768),
            child: Container(
              width: sw(1440),
              height: sh(256),
              padding: EdgeInsets.all(sw(20)),
              color: const Color(0xFF192734),
              child: showSettings
                  ? _settingsPanel(sw, sh)
                  : _logPanel(sw, sh),
            ),
          ),

          // Language buttons
          Positioned(
            left: sx(125),
            top: sy(132),
            child: _langButton(
              width: sw(158),
              height: sh(53),
              label: selectedInputLanguage,
              onTap: () => _showLanguageSelector(
                (val) => setState(() => selectedInputLanguage = val),
              ),
            ),
          ),

          Positioned(
            left: sx(397),
            top: sy(132),
            child: _langButton(
              width: sw(158),
              height: sh(53),
              label: selectedOutputLanguage,
              onTap: () => _showLanguageSelector(
                (val) => setState(() => selectedOutputLanguage = val),
              ),
            ),
          ),

          // Swap icon
          Positioned(
            left: sx(331),
            top: sy(150),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: swapLanguages,
                child: SvgPicture.asset(
                  "assets/icons/swapLanguageButton.svg",
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),  
        ],

        // About card
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
                            text: 'Project Lead\n'
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

  // Tab button
  Widget _tabButton({
    required double width,
    required double height,
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: active ? const Color(0xFF192734) : const Color(0xFF22303C),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : const Color(0xFF8899AC),
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  // Settings panel
  Widget _settingsPanel(
      double Function(double) sw, double Function(double) sh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Shift Cipher Settings",
            style: TextStyle(color: Colors.white, fontSize: sh(24))),
        SizedBox(height: sh(20)),
        TextField(
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
            labelText: "Shift Amount",
            labelStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  // Log panel
  Widget _logPanel(double Function(double) sw, double Function(double) sh) {
    return logs.isEmpty
        ? const Text("No logs yet.", style: TextStyle(color: Colors.white))
        : ListView.builder(
            itemCount: logs.length,
            itemBuilder: (_, i) => Text(
              logs[i],
              style: const TextStyle(color: Colors.white),
            ),
          );
  }

  // Language button
  Widget _langButton({
    required double width,
    required double height,
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF15202B),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }

  // Language selector modal
  void _showLanguageSelector(Function(String) onSelected) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF192734),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            title: Text("Select Language",
                style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            title:
                const Text("Plain Text", style: TextStyle(color: Colors.white)),
            onTap: () {
              onSelected("Plain Text");
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("Morse Code",
                style: TextStyle(color: Colors.white)),
            onTap: () {
              onSelected("Morse Code");
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("Shift Cipher",
                style: TextStyle(color: Colors.white)),
            onTap: () {
              onSelected("Shift Cipher");
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}