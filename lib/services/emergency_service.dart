import 'package:http/http.dart' as http;

class EmergencyService {
  static Future<void> logEmergency(String type) async {
    try {
      await http.post(
        Uri.parse("http://10.0.2.2:8000/emergency-log"), // Android emulator
        body: {
          "user_id": "123",
          "type": type,
        },
      );
    } catch (e) {
      // Fail silently – emergency must never be blocked
      print("Emergency log failed: $e");
    }
  }
}
