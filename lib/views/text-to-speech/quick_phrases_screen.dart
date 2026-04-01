import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickPhrasesScreen extends StatefulWidget {
  const QuickPhrasesScreen({Key? key}) : super(key: key);

  @override
  State<QuickPhrasesScreen> createState() => _QuickPhrasesScreenState();
}

class _QuickPhrasesScreenState extends State<QuickPhrasesScreen> {
  final TextEditingController _phraseController = TextEditingController();
  
  List<String> phrases = [
    'Thank you',
    'كيف حالك؟',
    'Where is the park?',
    'أحتاج إلى مساعدة',
    'Good morning',
    'مع السلامة',
  ];

  @override
  void dispose() {
    _phraseController.dispose();
    super.dispose();
  }

  void _addPhrase() {
    if (_phraseController.text.trim().isNotEmpty) {
      setState(() {
        phrases.add(_phraseController.text.trim());
        _phraseController.clear();
      });
    }
  }

  void _deletePhrase(int index) {
    setState(() {
      phrases.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF191834),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
          splashRadius: 24,
        ),
        title: Text(
          'Quick Phrases',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Phrases List
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              itemCount: phrases.length,
              itemBuilder: (context, index) {
                return _buildPhraseCard(phrases[index], index);
              },
            ),
          ),

          // Bottom Input Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Text Input Field
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F6F9),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _phraseController,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFF191834),
                          ),
                          decoration: InputDecoration(
                            hintText: 'write ...',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Add Button
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF191834),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _addPhrase,
                        borderRadius: BorderRadius.circular(25),
                        splashColor: Colors.white.withOpacity(0.1),
                        highlightColor: Colors.white.withOpacity(0.05),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'add',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // تم تعديل الأقواس والمحاذاة هنا بشكل دقيق
  Widget _buildPhraseCard(String phrase, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15), // زودت المسافة شوي عشان زر الحذف ياخذ راحته
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                // Phrase Text
                Expanded(
                  child: Text(
                    phrase,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF191834),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Speaker Button with Glow Effect
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4F4D78).withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Material(
                    color: const Color(0xFF4F4D78),
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: () {},
                      customBorder: const CircleBorder(),
                      splashColor: Colors.white.withOpacity(0.2),
                      highlightColor: Colors.white.withOpacity(0.1),
                      child: const Center(
                        child: Icon(
                          Icons.volume_up,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ], 
            ),
          ), 

          // Delete Icon (Bottom Right) 
          Positioned(
            bottom: -6,
            right: 8,
            child: GestureDetector(
              onTap: () => _deletePhrase(index),
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}