import 'package:flutter/material.dart';

// Build a warm, minimal Flutter splash screen for an app called "Digital Dadi".
// Theme: Indian, caring, calm, mother-friendly.
// UI elements:
// - Centered circular logo placeholder with soft pastel background
// - App name "Digital Dadi" in bold
// - Tagline: "A caring companion for new mothers"
// - Subtle fade-in animation
// - Small disclaimer text at the bottom:
//   "This app provides emotional support and general guidance. Not a medical substitute."
// Use Material 3, rounded corners, and soft colors (peach, beige, light pink).
// Ensure the layout is responsive and accessible.

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.pink[50], // Soft pastel background
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 2),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.baby_changing_station,
                    size: 50,
                    color: Colors.pink,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Digital Dadi',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'A caring companion for new mothers',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.brown,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'This app provides emotional support and general guidance. Not a medical substitute.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
