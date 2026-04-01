import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Shared iOS-style glassmorphism popup helper 
// ─────────────────────────────────────────────────────────────────────────────

Future<void> showIosStyleMenu({
  required BuildContext anchorContext,
  required List<String> options,
  required String current,
  required ValueChanged<String> onSelected,
}) async {
  final RenderBox button = anchorContext.findRenderObject() as RenderBox;
  final RenderBox overlay =
      Overlay.of(anchorContext).context.findRenderObject() as RenderBox;
  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      button.localToGlobal(Offset.zero, ancestor: overlay),
      button.localToGlobal(button.size.bottomRight(Offset.zero),
          ancestor: overlay),
    ),
    Offset.zero & overlay.size,
  );

  await showMenu<String>(
    context: anchorContext,
    position: position,
    elevation: 0,
    color: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    items: [
      PopupMenuItem<String>(
        enabled: false,
        padding: EdgeInsets.zero,
        child: _IosMenuCard(
          options: options,
          current: current,
          onSelected: (val) {
            Navigator.pop(anchorContext, val);
            onSelected(val);
          },
        ),
      ),
    ],
  );
}

class _IosMenuCard extends StatelessWidget {
  final List<String> options;
  final String current;
  final ValueChanged<String> onSelected;

  const _IosMenuCard({
    required this.options,
    required this.current,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.82),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 24,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.asMap().entries.map((entry) {
              final isLast = entry.key == options.length - 1;
              final opt = entry.value;
              final isSelected = opt == current;
              return Column(
                children: [
                  InkWell(
                    onTap: () => onSelected(opt),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            opt,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isSelected
                                  ? const Color(0xFF4F4D78)
                                  : Colors.black87,
                            ),
                          ),
                          if (isSelected)
                            const Icon(Icons.check_rounded,
                                size: 16, color: Color(0xFF4F4D78)),
                        ],
                      ),
                    ),
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      thickness: 0.5,
                      color: Colors.grey.shade300,
                      indent: 16,
                      endIndent: 16,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Unified dropdown field widget 
// ─────────────────────────────────────────────────────────────────────────────

class IosDropdownField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onSelected;
  final bool showLabel;

  const IosDropdownField({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.options,
    required this.onSelected,
    this.showLabel = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (ctx) => GestureDetector(
        onTap: () => showIosStyleMenu(
          anchorContext: ctx,
          options: options,
          current: value,
          onSelected: onSelected,
        ),
        child: showLabel ? _cardRow() : _dialogPill(),
      ),
    );
  }

  Widget _cardRow() {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade500),
        const SizedBox(width: 4),
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: 10, color: Colors.grey.shade600)),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value,
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
              const SizedBox(width: 2),
              const Icon(Icons.keyboard_arrow_down_rounded,
                  size: 13, color: Colors.black54),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dialogPill() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade500),
          const SizedBox(width: 8),
          Text(label,
              style: GoogleFonts.poppins(
                  fontSize: 13, color: Colors.grey.shade500)),
          const Spacer(),
          Text(value,
              style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF38385A))),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down_rounded,
              size: 16, color: Colors.black45),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Main Screen
// ─────────────────────────────────────────────────────────────────────────────

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyContactsScreen> createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> contacts = [
    {
      'name': 'Sara',
      'phone': '+966 50 123 4567',
      'relation': 'Sister',
      'timer': '5 min'
    },
    {
      'name': 'Ahmed',
      'phone': '+966 55 987 6543',
      'relation': 'Father',
      'timer': '3 min'
    },
  ];

  List<Map<String, String>> filteredContacts = [];
  final List<String> timerOptions = ['1 min', '3 min', '5 min', '10 min'];

  @override
  void initState() {
    super.initState();
    filteredContacts = List.from(contacts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _runFilter(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredContacts = List.from(contacts);
      } else {
        filteredContacts = contacts
            .where((contact) =>
                contact['name']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

 
  void _showAddOrEditDialog({Map<String, String>? contactToEdit}) {
    bool isEditing = contactToEdit != null;
    final nameController = TextEditingController(
        text: isEditing ? contactToEdit['name'] : '');
    final phoneController = TextEditingController(
        text: isEditing ? contactToEdit['phone'] : '');
    final relationController = TextEditingController(
        text: isEditing ? contactToEdit['relation'] : '');
    String selectedTimer = isEditing ? contactToEdit['timer']! : '5 min';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Text(
                isEditing ? 'Edit Contact' : 'Add New Contact',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF191834),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDialogTextField(nameController, 'Name'),
                  const SizedBox(height: 12),
                  _buildDialogTextField(phoneController, 'Phone', isPhone: true),
                  const SizedBox(height: 12),
                  _buildDialogTextField(relationController, 'Relation'),
                  const SizedBox(height: 12),
                  
                
                  IosDropdownField(
                    icon: Icons.timer,
                    label: 'Timer',
                    value: selectedTimer,
                    options: timerOptions,
                    showLabel: false,
                    onSelected: (val) =>
                        setDialogState(() => selectedTimer = val),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel',
                      style: GoogleFonts.poppins(color: Colors.grey)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F4D78),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    if (nameController.text.trim().isEmpty ||
                        phoneController.text.trim().isEmpty) return;
                    setState(() {
                      if (isEditing) {
                        contactToEdit['name'] = nameController.text.trim();
                        contactToEdit['phone'] = phoneController.text.trim();
                        contactToEdit['relation'] = relationController.text.trim();
                        contactToEdit['timer'] = selectedTimer;
                      } else {
                        contacts.insert(0, {
                          'name': nameController.text.trim(),
                          'phone': phoneController.text.trim(),
                          'relation': relationController.text.trim(),
                          'timer': selectedTimer,
                        });
                      }
                      _runFilter(_searchController.text);
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Save',
                      style: GoogleFonts.poppins(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDialogTextField(TextEditingController controller, String hint,
      {bool isPhone = false}) {
    return TextField(
      controller: controller,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            GoogleFonts.poppins(color: Colors.grey.shade400, fontSize: 13),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      ),
      style: GoogleFonts.poppins(fontSize: 13),
    );
  }


  void _showDeleteDialog(Map<String, String> contact) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          elevation: 10,
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Delete Contact',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: const Color(0xFF191834),
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to delete ${contact['name']}?',
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  contacts.remove(contact);
                  _runFilter(_searchController.text);
                });
                Navigator.pop(dialogContext); // إغلاق النافذة
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Delete',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ],
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
        automaticallyImplyLeading: false,
        title: Text(
          'Emergency Contacts',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF4F4D78),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _runFilter,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xFF191834),
                ),
                decoration: InputDecoration(
                  hintText: 'search',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 22,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          // Add Contact Button
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: GestureDetector(
              onTap: () => _showAddOrEditDialog(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E5EF),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.add,
                      color: Color(0xFF191834),
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Add Contact',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF191834),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Contacts List
          Expanded(
            child: filteredContacts.isEmpty
                ? Center(
                    child: Text(
                      'No contacts found.',
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                    itemCount: filteredContacts.length,
                    itemBuilder: (context, index) {
                      return _buildContactCard(filteredContacts[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(Map<String, String> contact) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Icon
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.person,
              color: Color(0xFF191834),
              size: 30,
            ),
          ),
          const SizedBox(width: 15),

          // Contact Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoField(contact['name']!, isLarge: true),
                const SizedBox(height: 8),
                _buildInfoField(contact['phone']!),
                const SizedBox(height: 8),
                _buildInfoField(contact['relation']!),
                const SizedBox(height: 8),

                // Timer Button 
                Builder(
                  builder: (ctx) => GestureDetector(
                    onTap: () => showIosStyleMenu(
                      anchorContext: ctx,
                      options: timerOptions,
                      current: contact['timer']!,
                      onSelected: (val) {
                        setState(() {
                          contact['timer'] = val;
                        });
                      },
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F6F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'set timer before sending: ${contact['timer']}',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 18,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Action Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Edit Button
                    GestureDetector(
                      onTap: () => _showAddOrEditDialog(contactToEdit: contact),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.edit_outlined,
                            color: Colors.grey.shade600, size: 18),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Delete Button
                    GestureDetector(
                      onTap: () => _showDeleteDialog(contact),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.delete_outline,
                            color: Colors.red, size: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField(String text, {bool isLarge = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: isLarge ? 14 : 12,
          fontWeight: isLarge ? FontWeight.w600 : FontWeight.w400,
          color: const Color(0xFF191834),
        ),
      ),
    );
  }
}