// lib/screens/menu_detail_screen.dart

import 'package:flutter/material.dart';
import '../models/menu.dart';

class MenuDetailScreen extends StatefulWidget {
  final Menu item;

  const MenuDetailScreen({super.key, required this.item});

  @override
  State<MenuDetailScreen> createState() => _MenuDetailScreenState();
}

class _MenuDetailScreenState extends State<MenuDetailScreen> {
  int _quantity = 1;
  String? _selectedSize;
  String? _selectedTemperature;
  bool _extraIce = false;
  final double _extraIcePrice = 3.0;
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inisialisasi state awal berdasarkan item yang diterima
    _selectedSize = widget.item.selectedSize;
    _selectedTemperature = widget.item.selectedTemperature;
    _extraIce = widget.item.extraIce ?? false;
    _quantity = widget.item.quantity;
    _notesController.text = widget.item.notes ?? '';
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  double get _totalPrice {
    double basePrice = widget.item.price;
    double discountedPrice = basePrice * (1 - widget.item.discount);
    double extrasPrice = (_extraIce ? _extraIcePrice : 0.0);
    return (discountedPrice + extrasPrice) * _quantity;
  }

  String _formatPrice(double price) {
    return 'Rp. ${(price * 1000).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  void _addToCart() {
    final updatedItem = widget.item.copyWith(
      quantity: _quantity,
      selectedSize: _selectedSize,
      selectedTemperature: _selectedTemperature,
      extraIce: _extraIce,
      notes: _notesController.text,
      price: widget.item.price, // Harga asli tetap
    );
    Navigator.pop(context, updatedItem);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.item.name} ditambahkan ke keranjang'),
        backgroundColor: const Color(0xFF8B4513),
      ),
    );
  }

  Widget _buildCategorySpecificOptions() {
    switch (widget.item.category) {
      case 'food':
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Catatan (Opsional)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _notesController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Misalnya: tidak pedas, tanpa saus...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        );
      case 'drink':
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilih Ukuran',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Regular'),
                      value: 'Regular',
                      groupValue: _selectedSize,
                      onChanged: (value) {
                        setState(() {
                          _selectedSize = value!;
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Large'),
                      value: 'Large',
                      groupValue: _selectedSize,
                      onChanged: (value) {
                        setState(() {
                          _selectedSize = value!;
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Pilih Suhu',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Dingin'),
                      value: 'Cold',
                      groupValue: _selectedTemperature,
                      onChanged: (value) {
                        setState(() {
                          _selectedTemperature = value!;
                          _extraIce = true; // Default extra ice for cold drinks
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Panas'),
                      value: 'Hot',
                      groupValue: _selectedTemperature,
                      onChanged: (value) {
                        setState(() {
                          _selectedTemperature = value!;
                          _extraIce = false; // No extra ice for hot drinks
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              // Extra Ice Option
              if (_selectedTemperature == 'Cold')
                CheckboxListTile(
                  title: Text('Extra Ice (+${_formatPrice(_extraIcePrice)})'),
                  value: _extraIce,
                  onChanged: (value) {
                    setState(() {
                      _extraIce = value!;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                ),
            ],
          ),
        );
      case 'dessert':
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Catatan (Opsional)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _notesController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Misalnya: tidak terlalu manis...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    double finalPrice = widget.item.price * (1 - widget.item.discount);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.name),
        backgroundColor: const Color(0xFF8B4513),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(
                      widget.item.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 100,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.item.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (widget.item.discount > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.cyan,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Diskon ${(widget.item.discount * 100).toStringAsFixed(0)}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Jenis: ${widget.item.category.toUpperCase()} • ${widget.item.description}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            if (widget.item.discount > 0)
                              Text(
                                _formatPrice(widget.item.price),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            const SizedBox(width: 8),
                            Text(
                              _formatPrice(finalPrice),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8B4513),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _buildCategorySpecificOptions(),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Text(
                              'Qty',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: _quantity > 1
                                        ? () {
                                            setState(() {
                                              _quantity--;
                                            });
                                          }
                                        : null,
                                    icon: const Icon(Icons.remove),
                                  ),
                                  SizedBox(
                                    width: 40,
                                    child: Center(
                                      child: Text(
                                        '$_quantity',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _quantity++;
                                      });
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _addToCart,
                icon: const Icon(Icons.shopping_cart),
                label: Text(
                  'Tambahkan ke Keranjang - ${_formatPrice(_totalPrice)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B4513),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}