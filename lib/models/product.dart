import 'package:flutter/material.dart';

class Product {
  Product(
      {required this.imagePath,
      required this.title,
      required this.destinationPage});

  final String title;
  final String imagePath;
  final String destinationPage;
}
