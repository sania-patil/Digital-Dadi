import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeBeforeLogin extends StatelessWidget {
  const HomeBeforeLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink[100]!, Colors.pink[50]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Digital Dadi',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'How Digital Dadi supports you:',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.brown,
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Text('• Emotional support for new mothers',
                        style: TextStyle(color: Colors.brown)),
                    Text('• Week-wise guidance for your journey',
                        style: TextStyle(color: Colors.brown)),
                    Text('• Safety tips and resources',
                        style: TextStyle(color: Colors.brown)),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to registration screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  ),
                  child: Text(
                    'Get Started',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.chat,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

