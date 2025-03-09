import 'package:flutter/material.dart';
import 'package:nimraapi/screens/Order_screens/Order_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:nimraapi/provider/order_provider.dart';

class OrderScreen extends StatelessWidget {
  final int orderId = 2; // Set order ID (can be dynamic)
  final int driverId = 30; // Set driver ID (can be dynamic)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Screen")),
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator()); // Show loader
          }

          if (provider.orderData == null) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  provider.fetchOrder(orderId, driverId);
                },
                child: Text("Fetch Order"),
              ),
            );
          }

          // Navigate to Order Details when order is fetched
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Order Fetched Successfully!"),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsScreen(
                          orderId: orderId,
                          driverId: driverId,
                        ),
                      ),
                    );
                  },
                  child: Text("View Order Details"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
