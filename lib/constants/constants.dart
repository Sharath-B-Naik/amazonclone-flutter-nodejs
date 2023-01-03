import 'package:flutter/material.dart';

List<Map<String, String>> get categories => [
      {
        "title": 'Mobiles',
        "image": 'assets/images/mobiles.jpeg',
      },
      {
        "title": 'Essentials',
        "image": 'assets/images/essentials.jpeg',
      },
      {
        "title": 'Appliances',
        "image": 'assets/images/appliances.jpeg',
      },
      {
        "title": 'Books',
        "image": 'assets/images/books.jpeg',
      },
      {
        "title": 'Fashion',
        "image": 'assets/images/fashion.jpeg',
      },
    ];

class Constants {
  static List<BoxShadow> get defualtBoxShadow => [
        BoxShadow(
          color: const Color(0xFF6E6D6D).withOpacity(0.1),
          blurRadius: 30,
          offset: const Offset(0, 14),
        )
      ];

  static List<String> get images => [
        "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
        "https://images.unsplash.com/photo-1572635196237-14b3f281503f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
        "https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
        "https://images.unsplash.com/photo-1485955900006-10f4d324d411?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1172&q=80",
        "https://images.unsplash.com/photo-1581235720704-06d3acfcb36f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
        "https://images.unsplash.com/photo-1504274066651-8d31a536b11a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80",
      ];
}
