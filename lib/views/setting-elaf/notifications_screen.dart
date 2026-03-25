import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool vibrationAlerts = true;
  bool flashlightAlerts = false;
  bool pushNotifications = true;
  bool soundDetectionAlerts = true;
  bool keywordAlerts = true;
  bool emergencySounds = true;

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
          'Notifications',
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
              'Alert Settings',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF191834),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Customize how you want to be alerted',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 15),

            // Wristband Alerts
            _buildNotificationCard([
              _buildSwitchTile(
                title: 'Vibration Alerts on Wristband',
                subtitle: 'Receive vibration patterns on your smart wristband',
                value: vibrationAlerts,
                onChanged: (val) => setState(() => vibrationAlerts = val),
                icon: Icons.vibration,
              ),
            ]),

            const SizedBox(height: 15),

            // Phone Alerts
            _buildNotificationCard([
              _buildSwitchTile(
                title: 'Phone Flashlight Alerts',
                subtitle: 'Flash your phone\'s LED when sounds are detected',
                value: flashlightAlerts,
                onChanged: (val) => setState(() => flashlightAlerts = val),
                icon: Icons.flash_on,
              ),
              const Divider(height: 1, thickness: 0.5, indent: 70, endIndent: 20),
              _buildSwitchTile(
                title: 'Push Notifications',
                subtitle: 'Show notifications on your phone screen',
                value: pushNotifications,
                onChanged: (val) => setState(() => pushNotifications = val),
                icon: Icons.notifications_active,
              ),
            ]),

            const SizedBox(height: 30),

            Text(
              'Sound Detection',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF191834),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Choose which sounds trigger alerts',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 15),

            _buildNotificationCard([
              _buildSwitchTile(
                title: 'Sound Library Alerts',
                subtitle: 'Get alerted for sounds in your library',
                value: soundDetectionAlerts,
                onChanged: (val) => setState(() => soundDetectionAlerts = val),
                icon: Icons.library_music,
              ),
              const Divider(height: 1, thickness: 0.5, indent: 70, endIndent: 20),
              _buildSwitchTile(
                title: 'Custom Keyword Alerts',
                subtitle: 'Alert when your keywords are detected',
                value: keywordAlerts,
                onChanged: (val) => setState(() => keywordAlerts = val),
                icon: Icons.key,
              ),
              const Divider(height: 1, thickness: 0.5, indent: 70, endIndent: 20),
              _buildSwitchTile(
                title: 'Emergency Sounds Priority',
                subtitle: 'Sirens, alarms, and fire alerts (always on)',
                value: emergencySounds,
                onChanged: null, // Always enabled
                icon: Icons.warning_amber_rounded,
              ),
            ]),

            const SizedBox(height: 30),

            // Info Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF4F4D78).withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color(0xFF4F4D78).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: const Color(0xFF4F4D78),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Emergency sounds are always enabled for your safety and cannot be turned off.',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
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
    );
  }

  Widget _buildNotificationCard(List<Widget> children) {
    return Container(
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
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>? onChanged,
    required IconData icon,
  }) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFF4F4D78),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF191834),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: Colors.grey.shade600,
        ),
      ),
      secondary: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF4F4D78),
          size: 22,
        ),
      ),
    );
  }
}