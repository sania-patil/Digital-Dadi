import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'chatbot_screen.dart';
import 'emergency_support_screen.dart';

class WeekTipsScreen extends StatefulWidget {
  final String language; // 'hi' or 'en'
  final int week; // which week to display (default: 1)

  const WeekTipsScreen({
    Key? key,
    this.language = 'en',
    this.week = 1,
  }) : super(key: key);

  @override
  State<WeekTipsScreen> createState() => _WeekTipsScreenState();
}

class _WeekTipsScreenState extends State<WeekTipsScreen> {
  late Future<Map<String, dynamic>> _weekDataFuture;

  @override
  void initState() {
    super.initState();
    _weekDataFuture = _loadWeekData();
  }

  /// Load week data from JSON asset
  Future<Map<String, dynamic>> _loadWeekData() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/week.json');
      final jsonData = json.decode(jsonString);
      final weeks = jsonData['weeks'] as List;

      // Find the week matching widget.week
      final weekData = weeks.firstWhere(
        (w) => w['week'] == widget.week,
        orElse: () => weeks[0], // fallback to first week
      );

      return weekData;
    } catch (e) {
      throw Exception('Error loading week data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFD4847A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Week ${widget.week} Guidance',
          style: const TextStyle(
            color: Color(0xFFD4847A),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.emergency, color: Colors.red),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmergencySupportScreen(),
                ),
              );
            },
            tooltip: 'Emergency Support',
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _weekDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFD4847A),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final weekData = snapshot.data ?? {};
          return _buildWeekContent(context, weekData);
        },
      ),
    );
  }

  /// Build the main week content
  Widget _buildWeekContent(
    BuildContext context,
    Map<String, dynamic> weekData,
  ) {
    // Extract language-specific data
    final title = _getText(weekData['title']);
    final intro = _getText(weekData['intro']);
    final tips = _getList(weekData['tips']);
    final recipeHint = _getText(weekData['recipe_hint']);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Week Title
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFD4847A),
                  ),
            ),
            const SizedBox(height: 16),

            // Intro Paragraph
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFDBF9D).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFFDBF9D).withOpacity(0.4),
                  width: 1,
                ),
              ),
              child: Text(
                intro,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 15,
                      color: const Color(0xFF3D2C2A),
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            const SizedBox(height: 28),

            // Tips Section
            Text(
              widget.language == 'hi' ? 'सुझाव' : 'Tips & Guidance',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF3D2C2A),
                  ),
            ),
            const SizedBox(height: 12),

            // Tips List
            _buildTipsList(tips),
            const SizedBox(height: 32),

            // Action Buttons
            _buildActionButtons(context, recipeHint),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// Build the tips list with bullet points
  Widget _buildTipsList(List<String> tips) {
    return Column(
      children: tips
          .asMap()
          .entries
          .map((entry) => _buildTipItem(entry.key + 1, entry.value))
          .toList(),
    );
  }

  /// Build individual tip card
  Widget _buildTipItem(int index, String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bullet or number
          Container(
            margin: const EdgeInsets.only(top: 6, right: 12),
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Color(0xFFD4847A),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$index',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          // Tip text
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF3D2C2A),
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build Recipe & Emergency buttons
  Widget _buildActionButtons(BuildContext context, String recipeHint) {
    return Column(
      children: [
        // View Recipe Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Navigate to chatbot screen with recipe hint
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatbotScreen(
                    recipeHint: recipeHint,
                    language: widget.language,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4847A),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.restaurant_menu, size: 20),
                const SizedBox(width: 8),
                Text(
                  widget.language == 'hi' ? 'रेसिपी देखें' : 'View Recipe',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Emergency Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _showEmergencyBottomSheet(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE74C3C),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.emergency, size: 20),
                const SizedBox(width: 8),
                Text(
                  widget.language == 'hi' ? 'आपातकाल' : 'Emergency',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Show emergency options bottom sheet
  void _showEmergencyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              widget.language == 'hi'
                  ? 'आपातकालीन सहायता'
                  : 'Emergency Assistance',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE74C3C),
              ),
            ),
            const SizedBox(height: 20),

            // Doctor Option
            _buildEmergencyOption(
              icon: Icons.local_hospital,
              title: widget.language == 'hi' ? 'डॉक्टर' : 'Call Doctor',
              subtitle: widget.language == 'hi'
                  ? 'तुरंत डॉक्टर से संपर्क करें'
                  : 'Contact a healthcare provider',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      widget.language == 'hi'
                          ? 'डॉक्टर को कॉल कर रहे हैं...'
                          : 'Calling doctor...',
                    ),
                  ),
                );
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 12),

            // Family Option
            _buildEmergencyOption(
              icon: Icons.group,
              title: widget.language == 'hi' ? 'परिवार' : 'Contact Family',
              subtitle: widget.language == 'hi'
                  ? 'परिवार के सदस्यों को कॉल करें'
                  : 'Alert family members',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      widget.language == 'hi'
                          ? 'परिवार को कॉल कर रहे हैं...'
                          : 'Calling family...',
                    ),
                  ),
                );
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 12),

            // Ambulance Option (108)
            _buildEmergencyOption(
              icon: Icons.medical_services,
              title: widget.language == 'hi' ? 'एम्बुलेंस' : 'Call Ambulance',
              subtitle: widget.language == 'hi' ? '108 डायल करें' : 'Dial 108',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      widget.language == 'hi'
                          ? '108 को कॉल कर रहे हैं...'
                          : 'Calling 108...',
                    ),
                  ),
                );
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20),

            // Close Button
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  widget.language == 'hi' ? 'बंद करें' : 'Close',
                  style: const TextStyle(
                    color: Color(0xFFB5A5A2),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build individual emergency option
  Widget _buildEmergencyOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFE74C3C).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE74C3C).withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFFE74C3C),
              size: 28,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE74C3C),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFB5A5A2),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFE74C3C),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  /// Helper: Get language-specific text
  String _getText(dynamic textObj) {
    if (textObj is Map) {
      return textObj[widget.language] ?? textObj['en'] ?? '';
    }
    return '';
  }

  /// Helper: Get language-specific list
  List<String> _getList(dynamic listObj) {
    if (listObj is Map) {
      final list = listObj[widget.language] ?? listObj['en'] ?? [];
      return List<String>.from(list);
    }
    return [];
  }
}
