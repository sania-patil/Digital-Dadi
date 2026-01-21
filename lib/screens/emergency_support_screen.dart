import 'package:flutter/material.dart';

class EmergencySupportScreen extends StatelessWidget {
  const EmergencySupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Emergency Support'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Section
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.shade100,
                      Colors.orange.shade100,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      Icons.health_and_safety,
                      size: 48,
                      color: Colors.red.shade700,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Emergency Support',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade900,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'For urgent situations only',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.red.shade700,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Emergency Action Cards
              // 1. Call Doctor
              _buildEmergencyCard(
                context,
                icon: Icons.medical_services,
                iconColor: Colors.blue,
                backgroundColor: Colors.blue.shade50,
                title: 'Call Doctor',
                description: 'Reach your doctor immediately',
                accentColor: Colors.blue.shade700,
              ),

              const SizedBox(height: 16),

              // 2. Call Family
              _buildEmergencyCard(
                context,
                icon: Icons.people,
                iconColor: Colors.green,
                backgroundColor: Colors.green.shade50,
                title: 'Call Family',
                description: 'Contact your trusted family member',
                accentColor: Colors.green.shade700,
              ),

              const SizedBox(height: 16),

              // 3. Call 108 Ambulance
              _buildEmergencyCard(
                context,
                icon: Icons.local_hospital,
                iconColor: Colors.deepOrange,
                backgroundColor: Colors.orange.shade50,
                title: 'Call 108 Ambulance',
                description: 'Emergency medical services',
                accentColor: Colors.deepOrange.shade700,
              ),

              const SizedBox(height: 40),

              // Safety Disclaimer
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.amber.shade50,
                  border: Border.all(
                    color: Colors.amber.shade200,
                    width: 1.5,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.amber.shade800,
                      size: 24,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Safety Notice',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.amber.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'This app does not replace professional medical care. Always seek immediate professional assistance in life-threatening situations.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.amber.shade900,
                            height: 1.4,
                          ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a single emergency action card
  Widget _buildEmergencyCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required String title,
    required String description,
    required Color accentColor,
  }) {
    return Card(
      elevation: 4,
      shadowColor: accentColor.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
          border: Border(
            left: BorderSide(
              color: accentColor,
              width: 4,
            ),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Action placeholder - no actual phone call logic required
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$title action triggered'),
                  duration: const Duration(seconds: 2),
                  backgroundColor: accentColor,
                ),
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  // Icon
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: iconColor.withOpacity(0.15),
                    ),
                    child: Icon(
                      icon,
                      size: 32,
                      color: iconColor,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Text Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: accentColor,
                                  ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          description,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey.shade700,
                                    height: 1.3,
                                  ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Arrow Icon
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: accentColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
