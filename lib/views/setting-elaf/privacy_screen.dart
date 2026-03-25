import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

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
          'Privacy Policy',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF191834),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Last Updated: March 2025',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
                           const SizedBox(height: 25),

              _buildSection(
                title: '1. Introduction',
                content:
                    'PulseHear we is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application and smart wristband service.',
              ),

              _buildSection(
                title: '2. Information We Collect',
                content:
                    'Audio Data: We process environmental audio to detect sounds and keywords. Audio recordings are analyzed in real-time on your device and are NOT stored permanently or transmitted to our servers.\n\nDevice & Location Information: We collect information about your wristband connection status and battery. In the event of an emergency, we access your device\'s location to send it to your trusted emergency contacts.\n\nEmergency Contacts: We store the phone numbers and names of the emergency contacts you explicitly add to the app.\n\nUsage Data: We collect anonymized data about which features you use to improve our service.',
              ),

              _buildSection(
                title: '3. How We Use Your Information',
                content:
                    'Sound Detection: Audio is processed locally on your device using AI models to identify sounds and keywords.\n\nPersonalization: Your keyword preferences and sound alert settings are stored locally on your device to provide personalized alerts.\n\nEmergency Response: If a critical alert is triggered and not canceled within the specified time, we use your location data to send an automated SMS/message to your designated emergency contacts to ensure your safety.\n\nService Improvement: Anonymized usage statistics help us improve detection accuracy and user experience.',
              ),

              _buildSection(
                title: '4. Data Security',
                content:
                    'We implement industry-standard security measures to protect your data:\n\n• All audio processing happens on-device in real-time\n• Your custom keywords and emergency contacts are encrypted and stored locally on your device\n• Bluetooth communication with the wristband is encrypted\n• We do not share your personal data with third parties for advertising purposes',
              ),

              _buildSection(
                title: '5. Data Retention',
                content:
                    'Audio recordings are processed in real-time and immediately discarded. Your configured keywords, settings, and emergency contacts are stored on your device until you delete them. You can clear all your data at any time through the app settings.',
              ),

              _buildSection(
                title: '6. Third-Party Services',
                content:
                    'PulseHear does not share your audio data with third-party services. We may use third-party analytics services that collect anonymized usage data to help us improve the app.',
              ),

              _buildSection(
                title: '7. Your Rights',
                content:
                    'You have the right to:\n\n• Access your stored data\n• Delete your account and all associated data\n• Opt out of analytics data collection\n• Request information about how your data is used',
              ),

              _buildSection(
                title: '8. Children\'s Privacy',
                content:
                    'PulseHear is not intended for children under 13 years of age. We do not knowingly collect personal information from children.',
              ),

              _buildSection(
                title: '9. Changes to This Policy',
                content:
                    'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last Updated" date.',
              ),

              _buildSection(
                title: '10. Contact Us',
                content:
                    'If you have questions about this Privacy Policy, please contact us at:\n\npulsehear@outlook.com',
              ),

              const SizedBox(height: 20),

              // Consent Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4F4D78).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF4F4D78).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.verified_user,
                      color: const Color(0xFF4F4D78),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Your privacy is our priority. All audio processing happens on your device.',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF191834),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
  })
   {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF191834),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.poppins(
              fontSize: 13,
              height: 1.6,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
