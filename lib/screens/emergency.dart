import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends StatelessWidget {

  Future<void> _makeCall(String number) async {
    final Uri uri = Uri.parse("tel:$number");
    if (!await launchUrl(uri)) {
      throw 'Could not call $number';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Emergency Help")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          ElevatedButton(
            onPressed: () => _makeCall("108"),
            child: Text("Call 108 Ambulance"),
          ),

          ElevatedButton(
            onPressed: () => _makeCall("9876543210"),
            child: Text("Call Doctor"),
          ),

          ElevatedButton(
            onPressed: () => _makeCall("9123456789"),
            child: Text("Call Family"),
          ),

        ],
      ),
    );
  }
}
