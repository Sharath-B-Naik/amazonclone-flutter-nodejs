import 'package:amazon_admin/config/routes/route_config.dart';
import 'package:amazon_admin/navigation_screen.dart';
import 'package:amazon_admin/providers/admin_provider.dart';
import 'package:amazon_admin/providers/auth_provider.dart';
import 'package:amazon_admin/providers/product_provider.dart';
import 'package:amazon_admin/providers/user_provider.dart';
import 'package:amazon_admin/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        title: 'Amazon Clone Admin ',
        theme: ThemeData(
          fontFamily: 'Montserrat',
          primarySwatch: Colors.teal,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        home: const SplashScreen(),
      ),
    );
  }
}
