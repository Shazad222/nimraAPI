import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: "https://laundry.saleselevation.tech"));

  Future<Response?> post(String endpoint, Map<String, dynamic> data,
      {bool requiresAuth = false}) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('security_token');

    // ✅ Debugging: Print if token is being added to headers
    print("📡 Making API Request to: $endpoint");
    if (requiresAuth) {
      print("🔐 Attaching Security Token: $token");
    }

    try {
      Response response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: {
          "Content-Type": "application/json",
          if (requiresAuth && token != null)
            "Security-Token": token, // ✅ Add token to headers
        }),
      );
      return response;
    } catch (e) {
      print("❌ API Error: $e");
      return null; // Prevent crashes
    }
  }
}
