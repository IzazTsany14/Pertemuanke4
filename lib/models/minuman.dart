// lib/models/minuman.dart
import 'package:project/models/menu.dart';

class Minuman extends Menu {
  final String category = 'drink';
  final String? notes;
  final String? selectedSize;
  final String? selectedTemperature;
  final bool? extraIce;
  final double discount;

  Minuman({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    this.notes,
    this.selectedSize,
    this.selectedTemperature,
    this.extraIce,
    this.discount = 0.0,
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          imageUrl: imageUrl,
        );
}