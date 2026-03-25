import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@pulsehear.com',
      query: 'subject=PulseHear Support Request',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
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
        ),
        title: Text(
          'Help & Support',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Support',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF191834),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'We\'re here to help you',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 15),

            // Email Card
            GestureDetector(
              onTap: _sendEmail,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
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
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.email_outlined,
                        color: Color(0xFF4F4D78),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email Support',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF191834),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'pulsehear@outlook.com',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: const Color(0xFF4F4D78),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF4F4D78),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              'Frequently Asked Questions',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF191834),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Find quick answers to common questions',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 15),

            // FAQ List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
                           child: Column(
                children: [
                  _buildFAQItem(
                    question: 'How do I pair my wristband?',
                    answer:
                        'You can pair your wristband using two ways:\n\n'
                        'Method 1: Quick Access\n'
                        '1. Go to the Home Dashboard.\n'
                        '2. Tap the connection icon on the top card.\n\n'
                        'Method 2: From Settings\n'
                        '1. Tap the Settings icon at the bottom.\n'
                        '2. Go to "Wristband Settings".\n\n'
                        'Make sure your phone\'s Bluetooth is turned on and the wristband is nearby.',
                  ),
                  const Divider(height: 1, thickness: 0.5),
                  _buildFAQItem(
                    question: 'How do I activate sounds?',
                    answer:
                        '1. Go to the Dashboard and tap "Sound Library"\n'
                        '2. Browse the pre-trained sounds (e.g., Fire Alarm, Baby Cry, Doorbell)\n'
                        '3. Turn on the switch next to the sound you want to be alerted for.',
                  ),
                  const Divider(height: 1, thickness: 0.5),
                  _buildFAQItem(
                    question: 'How do I add keywords?',
                    answer:
                        '1. Go to Dashboard and tap "Keywords"\n'
                        '2. Tap "Add Keyword" button\n'
                        '3. Type the word or phrase you want to detect\n'
                        '4. Select the language (Arabic or English)\n'
                        '5. Save and activate\n\n'
                        'Your wristband will vibrate when the AI detects this word.',
                  ),
                  const Divider(height: 1, thickness: 0.5),
                  _buildFAQItem(
                    question: 'Why is my wristband not vibrating?',
                    answer:
                        'Check these common solutions:\n\n'
                        '• Ensure the wristband is charged (battery > 20%)\n'
                        '• Verify Bluetooth connection is active\n'
                        '• Make sure the detected sound is active in your Sound Library\n'
                        '• Try restarting both the app and wristband\n\n'
                        'If the issue persists, contact our support team.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem({
    required String question,
    required String answer,
  }) {
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
        expansionTileTheme: const ExpansionTileThemeData(
          tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          question,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF191834),
          ),
        ),
        iconColor: const Color(0xFF4F4D78),
        collapsedIconColor: const Color(0xFF4F4D78),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: GoogleFonts.poppins(
                fontSize: 13,
                height: 1.5,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}