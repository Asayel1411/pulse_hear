import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class AppMode {
  final String id;
  String title;
  String imagePath;
  List<String> linkedSounds;
  bool isSelected;

  AppMode({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.linkedSounds,
    this.isSelected = false,
  });

  String get soundsSubtitle {
    if (linkedSounds.isEmpty) return "No sounds selected";
    if (linkedSounds.length > 2) {
      return "Sounds: ${linkedSounds[0]}, ${linkedSounds[1]}...";
    }
    return "Sounds: ${linkedSounds.join(' & ')}";
  }
}

class SelectModeScreen extends StatefulWidget {
  const SelectModeScreen({Key? key}) : super(key: key);

  @override
  State<SelectModeScreen> createState() => _SelectModeScreenState();
}

class _SelectModeScreenState extends State<SelectModeScreen> {
  List<AppMode> modesList = [
    AppMode(
      id: '1',
      title: 'Driving Mode',
      imagePath: 'assets/images/driving.png',
      linkedSounds: ['Horns', 'Sirens'],
      isSelected: true,
    ),
    AppMode(
      id: '2',
      title: 'Sleep Mode',
      imagePath: 'assets/images/sleep.png',
      linkedSounds: ['Alarms'],
    ),
    AppMode(
      id: '3',
      title: 'Study Mode',
      imagePath: 'assets/images/study.png',
      linkedSounds: ['Notifications'],
    ),
    AppMode(
      id: '4',
      title: 'General Mode',
      imagePath: 'assets/images/general.png',
      linkedSounds: ['All Sounds'],
    ),
  ];

  final List<String> allAvailableSounds = [
    'Horns',
    'Sirens',
    'Alarms',
    'Notifications',
    'Babies Crying',
    'Fire Alarms',
    'Doorbell'
  ];

  void _selectMode(String id) {
    setState(() {
      for (var mode in modesList) {
        mode.isSelected = (mode.id == id);
      }
    });
  }

  // ══════════════════════════════════════════════════════════════════════════
  // SHOW ADD MODE BOTTOM SHEET
  // ══════════════════════════════════════════════════════════════════════════
  void _showAddModeSheet() {
    TextEditingController titleController = TextEditingController();
    List<String> selectedSounds = [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle Bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title - Updated Color
                  Text(
                    'Create New Mode',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3B3970), // ← UPDATED COLOR
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Mode Name Input
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Mode Name (e.g., Gym Mode)',
                      hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: const Color(0xFFF4F6F9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: GoogleFonts.poppins(),
                  ),
                  const SizedBox(height: 20),

                  // Link Sounds Label - Updated Color
                  Text(
                    'Link Sounds:',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3B3970), // ← UPDATED COLOR
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Sounds List
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: allAvailableSounds.length,
                      itemBuilder: (context, index) {
                        final sound = allAvailableSounds[index];
                        final isSoundSelected = selectedSounds.contains(sound);
                        return CheckboxListTile(
                          title: Text(sound, style: GoogleFonts.poppins()),
                          activeColor: const Color(0xFF4F4D78),
                          value: isSoundSelected,
                          onChanged: (bool? value) {
                            setSheetState(() {
                              if (value == true) {
                                selectedSounds.add(sound);
                              } else {
                                selectedSounds.remove(sound);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),

                  // Add Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF191834),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        if (titleController.text.isNotEmpty) {
                          setState(() {
                            modesList.add(
                              AppMode(
                                id: DateTime.now().toString(),
                                title: titleController.text,
                                imagePath: 'assets/images/logo.png',
                                linkedSounds: selectedSounds.isEmpty
                                    ? ['No specific sounds']
                                    : selectedSounds,
                              ),
                            );
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Add Mode',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // SHOW EDIT MODE BOTTOM SHEET (NEW - FOR DOUBLE TAP)
  // ══════════════════════════════════════════════════════════════════════════
  void _showEditModeSheet(AppMode mode) {
    TextEditingController titleController =
        TextEditingController(text: mode.title);
    List<String> selectedSounds = List.from(mode.linkedSounds);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle Bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title - Updated Color
                  Text(
                    'Edit Mode',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3B3970), // ← UPDATED COLOR
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Mode Name Input
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Mode Name',
                      hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: const Color(0xFFF4F6F9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: GoogleFonts.poppins(),
                  ),
                  const SizedBox(height: 20),

                  // Link Sounds Label - Updated Color
                  Text(
                    'Link Sounds:',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3B3970), // ← UPDATED COLOR
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Sounds List
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: allAvailableSounds.length,
                      itemBuilder: (context, index) {
                        final sound = allAvailableSounds[index];
                        final isSoundSelected = selectedSounds.contains(sound);
                        return CheckboxListTile(
                          title: Text(sound, style: GoogleFonts.poppins()),
                          activeColor: const Color(0xFF4F4D78),
                          value: isSoundSelected,
                          onChanged: (bool? value) {
                            setSheetState(() {
                              if (value == true) {
                                selectedSounds.add(sound);
                              } else {
                                selectedSounds.remove(sound);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF191834),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        if (titleController.text.isNotEmpty) {
                          setState(() {
                            mode.title = titleController.text;
                            mode.linkedSounds = selectedSounds.isEmpty
                                ? ['No specific sounds']
                                : selectedSounds;
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Save Changes',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
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
          'Select Mode',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: modesList.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            if (index == modesList.length) {
              return _buildAddModeCard();
            }
            return _buildModeCard(modesList[index]);
          },
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // MODE CARD - WITH SINGLE TAP (SELECT) & DOUBLE TAP (EDIT)
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildModeCard(AppMode mode) {
    return GestureDetector(
      // Single Tap: Select Mode
      onTap: () => _selectMode(mode.id),
      
      // Double Tap: Edit Mode
      onDoubleTap: () => _showEditModeSheet(mode),
      
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: mode.isSelected ? const Color(0xFFD8DDE6) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: mode.isSelected
              ? Border.all(color: const Color(0xFF4F4D78), width: 1.5)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ── Image with Perfect Centering & Sizing ──────────────────
                Center(
                  child: Image.asset(
                    mode.imagePath,
                    width: 55, // ← FIXED SIZE
                    height: 55, // ← FIXED SIZE
                    fit: BoxFit.contain, // ← PROPER SCALING
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // ── Title with Updated Color ──────────────────────────────
                Text(
                  mode.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B3970), // ← UPDATED COLOR
                  ),
                ),
                const SizedBox(height: 4),

                // ── Subtitle ───────────────────────────────────────────────
                Text(
                  mode.soundsSubtitle,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),

            // ── Checkmark Icon for Selected Mode ──────────────────────────
            if (mode.isSelected)
              const Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.check_circle,
                  color: Color(0xFF4F4D78),
                  size: 22,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddModeCard() {
    return GestureDetector(
      onTap: _showAddModeSheet,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, size: 50, color: Color(0xFF4F4D78)),
            const SizedBox(height: 10),
            Text(
              'Add Mode',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4F4D78),
              ),
            ),
          ],
        ),
      ),
    );
  }
}