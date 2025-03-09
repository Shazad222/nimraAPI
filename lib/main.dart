import 'package:flutter/material.dart';
import 'package:nimraapi/provider/auth_provider.dart';
import 'package:nimraapi/provider/order_provider.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    ),
  );
}
