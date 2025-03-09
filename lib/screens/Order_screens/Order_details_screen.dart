import 'package:flutter/material.dart';
import 'package:nimraapi/provider/order_provider.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;
  final int driverId;

  const OrderDetailsScreen(
      {super.key, required this.orderId, required this.driverId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<OrderProvider>(context, listen: false)
          .fetchOrder(widget.orderId, widget.driverId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final order = orderProvider.orderData;
    final isLoading = orderProvider.isLoading;

    return Scaffold(
      appBar: AppBar(title: Text("Order Details")),
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loader while fetching data
          : order == null
              ? Center(child: Text("No order details found"))
              : order.containsKey("error") // Show error message if API fails
                  ? Center(
                      child: Text(
                        "Error: ${order['error']}",
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Customer Name
                          Text(
                            order['customer_name'] ?? "Unknown Customer",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),

                          // Pickup Details
                          Card(
                            color: Colors.blue.shade100,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.local_laundry_service,
                                          color: Colors.blue),
                                      SizedBox(width: 8),
                                      Text("Pickup",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Text(
                                    order['laundromat_name'] ??
                                        "No Laundromat Name",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    order['order_address'] ?? "No Address",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.blue),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "\$${order['order_price'] ?? "0.00"}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Dropoff Details
                          Card(
                            color: Colors.blue.shade100,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.home, color: Colors.blue),
                                      SizedBox(width: 8),
                                      Text("Drop",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Text(
                                    order['order_address'] ?? "No Drop Address",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Apt: ${order['apt_no'] ?? 'N/A'} | Floor: ${order['floor'] ?? 'N/A'}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                          order['elevator_status'] == "1"
                                              ? Icons.check_circle
                                              : Icons.cancel,
                                          color: Colors.blue),
                                      SizedBox(width: 5),
                                      Text(order['elevator_status'] == "1"
                                          ? "Elevator Available"
                                          : "No Elevator"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Order Instructions
                          Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.note, color: Colors.blue),
                                      SizedBox(width: 8),
                                      Text("Note",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Text(
                                    order['order_instructions'] ??
                                        "No instructions provided",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Spacer(),

                          // Arrived at Laundry Button
                          ElevatedButton(
                            onPressed: () {
                              // Handle button press logic here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              minimumSize: Size(double.infinity, 50),
                            ),
                            child: Text("Arrived at Laundry",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
    );
  }
}
