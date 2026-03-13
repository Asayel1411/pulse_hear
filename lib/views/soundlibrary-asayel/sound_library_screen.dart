import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// iOS glassmorphism popup — same helper used in KeywordsScreen
// ─────────────────────────────────────────────────────────────────────────────

Future<void> showIosStyleMenu({
  required BuildContext anchorContext,
  required List<String> options,
  required String current,
  required ValueChanged<String> onSelected,
}) async {
  final RenderBox button =
      anchorContext.findRenderObject() as RenderBox;
  final RenderBox overlay =
      Overlay.of(anchorContext).context.findRenderObject() as RenderBox;
  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      button.localToGlobal(Offset.zero, ancestor: overlay),
      button.localToGlobal(
          button.size.bottomRight(Offset.zero), ancestor: overlay),
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
  const _IosMenuCard(
      {required this.options,
      required this.current,
      required this.onSelected});

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
            border:
                Border.all(color: Colors.white.withOpacity(0.5), width: 1),
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
                          Text(opt,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isSelected
                                    ? const Color(0xFF4F4D78)
                                    : Colors.black87,
                              )),
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
                        endIndent: 16),
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
// SoundLibraryScreen
// ─────────────────────────────────────────────────────────────────────────────

class SoundLibraryScreen extends StatefulWidget {
  const SoundLibraryScreen({Key? key}) : super(key: key);

  @override
  State<SoundLibraryScreen> createState() => _SoundLibraryScreenState();
}

class _SoundLibraryScreenState extends State<SoundLibraryScreen> {
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _allSounds = [
    {
      'title': 'Fire Alarm',
      'sub': 'إنذار حريق',
      'img': 'assets/images/firealarm.png',
      'cat': 'Safety',
      'vib': 'Long',
      'isActive': true,
      'intensity': 0.4,
    },
    {
      'title': 'Car Horn',
      'sub': 'بوق السيارة',
      'img': 'assets/images/horn 1.png',
      'cat': 'Safety',
      'vib': 'Short',
      'isActive': false,
      'intensity': 0.1,
    },
    {
      'title': 'My Name',
      'sub': 'اسمي',
      'img': 'assets/images/girl 1.png',
      'cat': 'Communication',
      'vib': 'Medium',
      'isActive': true,
      'intensity': 0.5,
    },
    {
      'title': 'Baby Cry',
      'sub': 'بكاء طفل',
      'img': 'assets/images/baby-cry 1.png',
      'cat': 'Home',
      'vib': 'Long',
      'isActive': true,
      'intensity': 0.8,
    },
    {
      'title': 'Adhan',
      'sub': 'الأذان',
      'img': 'assets/images/mousq.png',
      'cat': 'Communication',
      'vib': 'Long',
      'isActive': true,
      'intensity': 0.4,
    },
    {
      'title': 'Doorbell',
      'sub': 'جرس الباب',
      'img': 'assets/images/doorbell 1.png',
      'cat': 'Home',
      'vib': 'Short',
      'isActive': true,
      'intensity': 0.9,
    },
  ];

  static const List<String> _categories = [
    'All',
    'Safety',
    'Home',
    'Emergency',
    'Communication',
  ];

  static const List<String> _vibrationOptions = ['Short', 'Medium', 'Long'];

  List<Map<String, dynamic>> get _filtered {
    return _allSounds.where((s) {
      final catOk =
          _selectedCategory == 'All' || s['cat'] == _selectedCategory;
      final q = _searchQuery.toLowerCase();
      final searchOk = q.isEmpty ||
          (s['title'] as String).toLowerCase().contains(q) ||
          (s['sub'] as String).toLowerCase().contains(q);
      return catOk && searchOk;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final sounds = _filtered;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF191834),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Sound Library',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),

            // ── Search bar ─────────────────────────────────────────────────
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (q) => setState(() => _searchQuery = q),
                decoration: InputDecoration(
                  hintText: 'search',
                  hintStyle:
                      GoogleFonts.poppins(color: Colors.grey.shade400),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 15),
                  suffixIcon:
                      Icon(Icons.search, color: Colors.grey.shade600),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ── Category chips — داخل حاوية رمادية مثل الصورة الأصلية ──────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
              decoration: BoxDecoration(
                color: const Color(0xFFB2B3BD),
                borderRadius: BorderRadius.circular(18),
              ),
              child: SizedBox(
                height: 38,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 6),
                  itemBuilder: (_, i) {
                    final cat = _categories[i];
                    final sel = _selectedCategory == cat;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = cat),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: sel ? const Color(0xFF191834) : Colors.white,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          cat,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: sel ? Colors.white : const Color(0xFF38385A),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ── Grid — dynamic height (hug content) ───────────────────────
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: LayoutBuilder(
                  builder: (ctx, constraints) {
                    final cardWidth =
                        (constraints.maxWidth - 15) / 2; // 2 cols, 15 gap
                    return Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      children: sounds.map((s) => SizedBox(
                        width: cardWidth,
                        child: _SoundCard(
                          sound: s,
                          vibrationOptions: _vibrationOptions,
                          onChanged: () => setState(() {}),
                        ),
                      )).toList(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _SoundCard
// ─────────────────────────────────────────────────────────────────────────────

class _SoundCard extends StatelessWidget {
  final Map<String, dynamic> sound;
  final List<String> vibrationOptions;
  final VoidCallback onChanged;

  const _SoundCard({
    required this.sound,
    required this.vibrationOptions,
    required this.onChanged,
  });

  static const Color _accent = Color(0xFF4F4D78);

  @override
  Widget build(BuildContext context) {
    final bool isActive = sound['isActive'] as bool;
    final double intensity = sound['intensity'] as double;
    final String vib = sound['vib'] as String;

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.055),
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 1. Image + Switch ───────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF0F8),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    sound['img'] as String,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Transform.scale(
                scale: 0.82,
                alignment: Alignment.centerRight,
                child: Switch(
                  value: isActive,
                  onChanged: (val) {
                    sound['isActive'] = val;
                    onChanged();
                  },
                  activeColor: _accent,
                  activeTrackColor: _accent.withOpacity(0.25),
                  inactiveThumbColor: Colors.grey.shade400,
                  inactiveTrackColor: Colors.grey.shade200,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // ── 2. EN title + AR subtitle ───────────────────────────────────
          Text(
            sound['title'] as String,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              height: 1.2,
              color: const Color(0xFF1E1E3A),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            sound['sub'] as String,
            style: GoogleFonts.cairo(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.3,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 10),

          // ── 3. Vibration Pattern ────────────────────────────────────────
          Builder(
            builder: (ctx) => GestureDetector(
              onTap: () => showIosStyleMenu(
                anchorContext: ctx,
                options: vibrationOptions,
                current: vib,
                onSelected: (val) {
                  sound['vib'] = val;
                  onChanged();
                },
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 9),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EAF2),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Vibration Pattern',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down,
                        color: Color(0xFF1D1B3F), size: 22),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ── 4. Intensity — العنوان ──────────────────────────────────────
          const Text(
            'Intensity',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1E3A),
            ),
          ),
          const SizedBox(height: 4),

          // ── Low / Medium / High — تحت العنوان مباشرة ──────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _intensityLabel('Low', 0.0, intensity),
              _intensityLabel('Medium', 0.5, intensity),
              _intensityLabel('High', 1.0, intensity),
            ],
          ),

          // ── 5. Slider ───────────────────────────────────────────────────
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 4,
              activeTrackColor: const Color(0xFF1D1B3F),
              inactiveTrackColor: const Color(0xFFD1D5E8),
              thumbColor: const Color(0xFF1D1B3F),
              thumbShape:
                  const RoundSliderThumbShape(enabledThumbRadius: 7),
              overlayShape:
                  const RoundSliderOverlayShape(overlayRadius: 14),
              overlayColor: const Color(0xFF1D1B3F).withOpacity(0.1),
            ),
            child: Slider(
              value: intensity,
              onChanged: (v) {
                sound['intensity'] = v;
                onChanged();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _intensityLabel(String label, double value, double current) {
    final bool active = (current - value).abs() < 0.06;
    return GestureDetector(
      onTap: () {
        sound['intensity'] = value;
        onChanged();
      },
      child: Text(
        label,
        style: TextStyle(
          fontSize: 8,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
          color: active ? const Color(0xFF1D1B3F) : Colors.black54,
        ),
      ),
    );
  }
}