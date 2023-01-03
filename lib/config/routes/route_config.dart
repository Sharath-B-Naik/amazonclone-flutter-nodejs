import 'package:amazon_admin/all_product_page.dart';
import 'package:amazon_admin/navigation_screen.dart';
import 'package:amazon_admin/screens/AddProduct/add_product_page.dart';
import 'package:amazon_admin/screens/Auth/auth_page.dart';
import 'package:amazon_admin/screens/Home/home_page.dart';
import 'package:amazon_admin/widgets/app_text.dart';
import 'package:flutter/material.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthPage.routename:
      return MaterialPageRoute(builder: (_) => const AuthPage());

    case HomePage.routename:
      return MaterialPageRoute(builder: (_) => const HomePage());

    case AddProductPage.routename:
      return MaterialPageRoute(builder: (_) => const AddProductPage());

    case NavigationPage.routename:
      return MaterialPageRoute(builder: (_) => const NavigationPage());

    case AllProductPage.routename:
      return MaterialPageRoute(builder: (_) => const AllProductPage());

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Column(
              children: [
                AppText('Route name ${settings.name} is not found'),
              ],
            ),
          ),
        ),
      );
  }
}

// Function(RouteSettings)?