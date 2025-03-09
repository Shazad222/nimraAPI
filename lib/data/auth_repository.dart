import 'package:nimraapi/core/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  Future<bool> driverLogin(String email, String password) async {
    final response = await _apiService.post(
      "/driver_api/driver_login.php",
      {"driver_email": email, "driver_password": password},
    );

    if (response == null) {
      print("❌ Error: No response from API");
      return false;
    }

    // ✅ Print full response for debugging
    print("🔍 Full API Response: ${response.data}");

    // ✅ Extract important fields safely
    String? responseCode = response.data["ResponseCode"];
    String? result = response.data["Result"];
    String? responseMsg = response.data["ResponseMsg"];
    var driverDetails = response.data["DriverDetails"];

    // ✅ Debug values before checking condition
    print("➡️ ResponseCode: $responseCode");
    print("➡️ Result: $result");
    print("➡️ Message: $responseMsg");
    print("➡️ DriverDetails: $driverDetails");

    // ✅ Fix the success condition
    if (responseCode == "200" && result == "true" && driverDetails != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('security_token', driverDetails["security_token"]);

      print(
          "✅ Login successful! Token saved: ${driverDetails["security_token"]}");
      return true;
    } else {
      print("❌ Login failed with response: ${response.data}");
      return false;
    }
  }
}
