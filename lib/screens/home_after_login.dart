import 'package:flutter/material.dart';
import 'week_tips_screen.dart';
import 'emergency.dart';

class HomeAfterLoginScreen extends StatelessWidget {
  const HomeAfterLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2), // Soft beige background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Warm Greeting
                Text(
                  'Namaste, Beti❤️',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFD4847A), // Warm rose
                      ),
                ),
                const SizedBox(height: 12),

                // Supportive Subtitle
                Text(
                  'You\'re doing an amazing job. We\'re here to support you every step of the way.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        color: const Color(0xFF8B6B66), // Warm brown
                        height: 1.5,
                      ),
                ),
                const SizedBox(height: 32),

                // Care Stage Card
                _buildCareStageCard(context),
                const SizedBox(height: 32),

                // View Daily Tips Button
                _buildDailyTipsButton(context),
                const SizedBox(height: 32),

                // Additional Info Card
                _buildInfoCard(),
              ],
            ),
          ),
        ),
      ),
<<<<<<< Updated upstream
      //added emergency button
=======
       //added emergency button
>>>>>>> Stashed changes
  floatingActionButton: FloatingActionButton(
    backgroundColor: Colors.red,
    child: const Icon(Icons.call, color: Colors.white),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmergencyScreen(),
        ),
      );
    },
  ),
);
<<<<<<< Updated upstream
}
 
=======
  }

>>>>>>> Stashed changes
  /// Build the care stage summary card
  Widget _buildCareStageCard(BuildContext context) {
    // Mock data
    const careStage = 'Postpartum'; // or 'Pregnancy'
    const babyAge = '2 months';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4847A).withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Care Journey',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 14,
                  color: const Color(0xFF8B6B66),
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFFFDBF9D), // Peach accent
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                careStage,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3D2C2A), // Dark brown
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Baby Age: $babyAge',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  color: const Color(0xFFB5A5A2),
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Tips and guidance tailored for this stage of your journey.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 13,
                  color: const Color(0xFFB5A5A2),
                  height: 1.4,
                ),
          ),
        ],
      ),
    );
  }

  /// Build the View Daily Tips button
  Widget _buildDailyTipsButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WeekTipsScreen(
                language: 'en',
                week: 1,
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
        child: Text(
          'View Daily Tips',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
        ),
      ),
    );
  }

  /// Build additional informational card
  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDBF9D).withOpacity(0.3), // Light peach
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFFDBF9D).withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
            color: Color(0xFFD4847A),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Remember: Self-care is essential. Take time for yourself today.',
              style: TextStyle(
                fontSize: 13,
                color: const Color(0xFF8B6B66),
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
