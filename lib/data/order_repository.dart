// import 'package:nimraapi/core/api_services.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class OrderRepository {
//   final ApiService _apiService = ApiService();

//   Future<Map<String, dynamic>> getOrderById(int orderId, int driverId) async {
//     final prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('security_token');

//     // ✅ Debugging: Print token
//     print("🔑 Retrieved Security Token: $token");

//     if (token == null) throw Exception("User not authenticated");

//     final response = await _apiService.post(
//       "/driver_api/get_order_by_id.php",
//       {"order_id": orderId, "assign_driver_id": driverId},
//       requiresAuth: true, // ✅ Ensures token is sent
//     );

//     if (response == null) {
//       throw Exception("Failed to fetch order: No response from API");
//     }

//     if (response.statusCode == 200) {
//       return response.data;
//     } else {
//       throw Exception("Failed to fetch order: ${response.data}");
//     }
//   }
// }

import 'package:nimraapi/core/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepository {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> getOrderById(int orderId, int driverId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('security_token');

    if (token == null) throw Exception("User not authenticated");

    final response = await _apiService.post(
      "/driver_api/get_order_by_id.php",
      {"order_id": orderId, "assign_driver_id": driverId},
      requiresAuth: true,
    );

    if (response == null) {
      throw Exception("Failed to fetch order: No response from API");
    }

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("Failed to fetch order: ${response.data}");
    }
  }
}
