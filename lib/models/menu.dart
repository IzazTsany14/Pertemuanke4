// lib/models/menu.dart

import 'package:project/models/dessert.dart';
import 'package:project/models/makanan.dart';
import 'package:project/models/minuman.dart';

abstract class Menu {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int quantity; // Tambahkan properti quantity di sini

  Menu({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.quantity = 1, // Beri nilai default 1
  });

  get selectedSize => null;

  get selectedTemperature => null;

  get category => null;

  get discount => null;

  get extraIce => null;

  get notes => null;
}

extension MenuCopy on Menu {
  Menu copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    int? quantity,
    double? discount,
    String? notes,
    String? selectedSize,
    String? selectedTemperature,
    bool? extraIce,
  }) {
    if (this is Makanan) {
      return Makanan(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
        discount: discount ?? (this as Makanan).discount,
      );
    } else if (this is Minuman) {
      return Minuman(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
        discount: discount ?? (this as Minuman).discount,
        notes: notes ?? (this as Minuman).notes,
        selectedSize: selectedSize ?? (this as Minuman).selectedSize,
        selectedTemperature: selectedTemperature ?? (this as Minuman).selectedTemperature,
        extraIce: extraIce ?? (this as Minuman).extraIce,
      );
    } else if (this is Dessert) {
      return Dessert(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
        discount: discount ?? (this as Dessert).discount,
      );
    }
    return this;
  }
}