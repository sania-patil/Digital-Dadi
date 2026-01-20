import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/emergency_service.dart';

class EmergencyScreen extends StatelessWidget {

  Future<void> _callNumber(String number,String type) async {
    await EmergencyService.logEmergency(type);
    final Uri uri = Uri.parse("tel:$number");
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Emergency Help")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          ElevatedButton(
            onPressed: () => _callNumber("108",'ambulance'),
            child: const Text("Call 108 Ambulance"),
          ),

          ElevatedButton(
            onPressed: () => _callNumber("9876543210",'doctor'),
            child: const Text("Call Doctor"),
          ),

          ElevatedButton(
            onPressed: () => _callNumber("9123456789",'family'),
            child: const Text("Call Family"),
          ),

        ],
      ),
    );
  }
}
