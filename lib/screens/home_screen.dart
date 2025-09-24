// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../models/menu.dart';
import '../models/menu_data.dart';
import '../widgets/menu_card.dart';
import '../widgets/cart_icon.dart';
import 'cart_screen.dart';
import 'menu_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  final String username;

  const HomeScreen({
    super.key,
    required this.userName,
    required this.username,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  List<Menu> cartItems = [];
  String selectedCategory = 'Semua';
  String _selectedSort = 'Nama (A-Z)';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _clearCart() {
    setState(() => cartItems = []);
  }

  void addToCart(Menu item) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MenuDetailScreen(item: item),
      ),
    );

    if (result != null && result is Menu) {
      setState(() {
        final existingIndex = cartItems.indexWhere(
          (cartItem) =>
              cartItem.id == result.id &&
              cartItem.selectedSize == result.selectedSize &&
              cartItem.selectedTemperature == result.selectedTemperature,
        );

        if (existingIndex >= 0) {
          cartItems[existingIndex] = cartItems[existingIndex].copyWith(
            quantity: cartItems[existingIndex].quantity + result.quantity,
          );
        } else {
          cartItems.add(result);
        }
      });
    }
  }

  List<Menu> get filteredItems {
    List<Menu> allItems = [
      ...MenuData.foodItems,
      ...MenuData.drinkItems,
      ...MenuData.dessertItems,
    ];

    // Filter kategori
    if (selectedCategory != 'Semua') {
      allItems = allItems.where((item) {
        switch (selectedCategory) {
          case 'Makanan':
            return item.category == 'food';
          case 'Minuman':
            return item.category == 'drink';
          case 'Dessert':
            return item.category == 'dessert';
          default:
            return true;
        }
      }).toList();
    }

    // Filter pencarian
    if (_searchController.text.isNotEmpty) {
      allItems = allItems
          .where((item) => item.name
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    }

    // Sorting
    switch (_selectedSort) {
      case 'Nama (A-Z)':
        allItems.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case 'Nama (Z-A)':
        allItems.sort(
            (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
        break;
      case 'Harga Terendah':
        allItems.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Harga Tertinggi':
        allItems.sort((a, b) => b.price.compareTo(a.price));
        break;
    }

    return allItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar dan Header
          SliverAppBar(
            backgroundColor: const Color(0xFF8B4513),
            foregroundColor: Colors.white,
            expandedHeight: 320,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  const Image(
                    image: NetworkImage(
                      'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg',
                    ),
                    fit: BoxFit.cover,
                  ),
                  Container(color: Colors.black.withOpacity(0.5)),
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Menu Kami',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Pilihan menu lezat yang tersedia di Cafe Zayyani\'s',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Bagian bawah AppBar (search & filter)
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Cari menu...',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            onChanged: (value) => setState(() {}),
                          ),
                        ),
                        const SizedBox(width: 8),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedSort,
                            icon: const Icon(Icons.sort),
                            items: const [
                              DropdownMenuItem(
                                value: 'Nama (A-Z)',
                                child: Text('Nama (A-Z)'),
                              ),
                              DropdownMenuItem(
                                value: 'Nama (Z-A)',
                                child: Text('Nama (Z-A)'),
                              ),
                              DropdownMenuItem(
                                value: 'Harga Terendah',
                                child: Text('Harga Terendah'),
                              ),
                              DropdownMenuItem(
                                value: 'Harga Tertinggi',
                                child: Text('Harga Tertinggi'),
                              ),
                            ],
                            onChanged: (String? newValue) {
                              setState(() => _selectedSort = newValue!);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Tombol kategori
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCategoryButton('Semua'),
                        _buildCategoryButton('Makanan'),
                        _buildCategoryButton('Minuman'),
                        _buildCategoryButton('Dessert'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            leading: const Icon(Icons.local_cafe, color: Colors.white, size: 28),
            title: Text(
              'Hi, ${widget.userName}',
              style: const TextStyle(fontSize: 16),
            ),
            actions: [
              CartIcon(
                itemCount: cartItems.fold(0, (sum, item) => sum + item.quantity),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(
                        cartItems: cartItems,
                        onCheckoutSuccess: _clearCart,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 16),
            ],
          ),

          // Label kategori
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    selectedCategory == 'Makanan'
                        ? Icons.restaurant
                        : selectedCategory == 'Minuman'
                            ? Icons.local_cafe
                            : selectedCategory == 'Dessert'
                                ? Icons.cake
                                : Icons.fastfood,
                    color: const Color(0xFF8B4513),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    selectedCategory,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B4513),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Daftar menu dengan SliverGrid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = filteredItems[index];
                  return MenuCard(
                    item: item,
                    onAddToCart: () => addToCart(item),
                  );
                },
                childCount: filteredItems.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget tombol kategori
  Widget _buildCategoryButton(String category) {
    final bool selected = selectedCategory == category;
    return ElevatedButton(
      onPressed: () {
        setState(() => selectedCategory = category);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? const Color(0xFF8B4513) : Colors.white,
        foregroundColor: selected ? Colors.white : Colors.black,
        side: BorderSide(
          color: selected ? const Color(0xFF8B4513) : Colors.grey,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(category),
    );
  }
}
