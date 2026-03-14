import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
          'Profile',
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
          children: [
            const SizedBox(height: 20),

            // Profile Picture with Camera Icon
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: const Color(0xFFF0F0F5),
                  child: Text(
                    'E',
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF4F4D78),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Change profile picture clicked',
                              style: GoogleFonts.poppins()),
                          backgroundColor: const Color(0xFF4F4D78),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4F4D78),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // User Name
            Text(
              'Elaf',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF191834),
              ),
            ),

            const SizedBox(height: 5),

            // Email
            Text(
              'elaf@example.com',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 40),

            // Profile Options
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
                  _buildProfileOption(
                    context,
                    icon: Icons.edit,
                    title: 'Edit Personal Info',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Edit Personal Info clicked',
                              style: GoogleFonts.poppins()),
                          backgroundColor: const Color(0xFF4F4D78),
                        ),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildProfileOption(
                    context,
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Change Password clicked',
                              style: GoogleFonts.poppins()),
                          backgroundColor: const Color(0xFF4F4D78),
                        ),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildProfileOption(
                    context,
                    icon: Icons.accessibility_new,
                    title: 'Accessibility Preferences',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Accessibility Preferences clicked',
                              style: GoogleFonts.poppins()),
                          backgroundColor: const Color(0xFF4F4D78),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
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
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF191834),
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Color(0xFF4F4D78),
        size: 16,
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 0.5,
      indent: 70,
      endIndent: 20,
    );
  }
}