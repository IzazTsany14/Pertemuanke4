// lib/models/dessert.dart
import 'package:project/models/menu.dart';

class Dessert extends Menu {
  final double discount;
  final String category = 'dessert';

  Dessert({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    this.discount = 0.0,
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          imageUrl: imageUrl,
        );
}