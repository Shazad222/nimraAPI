import 'package:flutter/material.dart';
import '../data/order_repository.dart';

class OrderProvider with ChangeNotifier {
  final OrderRepository _orderRepository = OrderRepository();

  Map<String, dynamic>? _orderData;
  bool _isLoading = false;

  Map<String, dynamic>? get orderData => _orderData;
  bool get isLoading => _isLoading;

  // ✅ Fetch order by ID
  Future<void> fetchOrder(int orderId, int driverId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _orderRepository.getOrderById(orderId, driverId);
      _orderData = response["OrderDetails"]; // Extract only OrderDetails
      notifyListeners();
    } catch (e) {
      _orderData = {"error": e.toString()};
    }

    _isLoading = false;
    notifyListeners();
  }

  // ✅ Refresh Order Data
  Future<void> refreshOrder(int orderId, int driverId) async {
    await fetchOrder(orderId, driverId);
  }
}
