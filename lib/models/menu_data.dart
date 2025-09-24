import 'package:project/models/dessert.dart';
import 'package:project/models/makanan.dart';
import 'package:project/models/minuman.dart';

class MenuData {
  static List<Makanan> foodItems = [
    Makanan(
      id: 'f1',
      name: 'Beef Burger',
      description: 'Juicy beef patty with fresh lettuce, tomato, and special sauce',
      price: 12.99,
      imageUrl: 'https://images.pexels.com/photos/1639557/pexels-photo-1639557.jpeg',
    ),
     Makanan(
      id: 'f2',
      name: 'Chicken Sandwich',
      description: 'Grilled chicken breast with avocado and crispy bacon',
      price: 10.99,
      imageUrl: 'https://images.pexels.com/photos/2282532/pexels-photo-2282532.jpeg',
    ),
    Makanan(
      id: 'f3',
      name: 'Caesar Salad',
      description: 'Fresh romaine lettuce with parmesan cheese and croutons',
      price: 8.99,
      imageUrl: 'https://images.pexels.com/photos/1059905/pexels-photo-1059905.jpeg',
    ),
    Makanan(
      id: 'f4',
      name: 'Pasta Carbonara',
      description: 'Creamy pasta with bacon, eggs, and parmesan cheese',
      price: 14.99,
      imageUrl: 'https://images.pexels.com/photos/1279330/pexels-photo-1279330.jpeg',
    ),
    Makanan(
      id: 'f5',
      name: 'Fish & Chips',
      description: 'Crispy battered fish with golden french fries',
      price: 13.99,
      imageUrl: 'https://images.pexels.com/photos/1633578/pexels-photo-1633578.jpeg',
    ),
    Makanan(
      id: 'f6',
      name: 'Pizza Margherita',
      description: 'Classic pizza with tomato sauce, mozzarella, and fresh basil',
      price: 15.99,
      imageUrl: 'https://images.pexels.com/photos/315755/pexels-photo-315755.jpeg',
    ),
  ];

  static List<Minuman> drinkItems = [
    Minuman(
      id: 'd1',
      name: 'Espresso',
      description: 'Rich and bold Italian espresso shot',
      price: 3.99,
      imageUrl: 'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg',
      notes: 'No sugar',
      selectedSize: 'small',
    ),
    Minuman(
      id: 'd2',
      name: 'Cappuccino',
      description: 'Perfect blend of espresso, steamed milk, and foam',
      price: 4.99,
      imageUrl: 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg',
    ),
    Minuman(
      id: 'd3',
      name: 'Latte',
      description: 'Smooth espresso with steamed milk and light foam',
      price: 5.49,
      imageUrl: 'https://images.pexels.com/photos/324028/pexels-photo-324028.jpeg',
    ),
    Minuman(
      id: 'd4',
      name: 'Iced Coffee',
      description: 'Refreshing cold brew coffee served over ice',
      price: 4.49,
      imageUrl: 'https://www.windingcreekranch.org/wp-content/uploads/2022/05/Homemade-iced-coffee-1200-1200.jpg',
      discount: 0.15,
    ),
    Minuman(
      id: 'd5',
      name: 'Green Tea',
      description: 'Premium organic green tea with antioxidants',
      price: 3.49,
      imageUrl: 'https://images.pexels.com/photos/1638280/pexels-photo-1638280.jpeg',
    ),
    Minuman(
      id: 'd6',
      name: 'Fresh Orange Juice',
      description: 'Freshly squeezed orange juice packed with vitamin C',
      price: 4.99,
      imageUrl: 'https://images.pexels.com/photos/96974/pexels-photo-96974.jpeg',
    ),
  ];

  static List<Dessert> dessertItems = [
    Dessert(
      id: 'ds1',
      name: 'Chocolate Cake',
      description: 'Rich chocolate cake with creamy chocolate frosting',
      price: 6.99,
      imageUrl: 'https://images.pexels.com/photos/291528/pexels-photo-291528.jpeg',
      discount: 0.10,
    ),
    Dessert(
      id: 'ds2',
      name: 'Cheesecake',
      description: 'Classic New York style cheesecake with berry topping',
      price: 7.49,
      imageUrl: 'https://images.pexels.com/photos/1126359/pexels-photo-1126359.jpeg',
    ),
    Dessert(
      id: 'ds3',
      name: 'Tiramisu',
      description: 'Italian dessert with coffee-soaked ladyfingers and mascarpone',
      price: 8.99,
      imageUrl: 'https://images.pexels.com/photos/6880219/pexels-photo-6880219.jpeg',
    ),
    Dessert(
      id: 'ds4',
      name: 'Ice Cream Sundae',
      description: 'Vanilla ice cream with chocolate sauce and whipped cream',
      price: 5.99,
      imageUrl: 'https://images.pexels.com/photos/1352278/pexels-photo-1352278.jpeg',
    ),
    Dessert(
      id: 'ds5',
      name: 'Apple Pie',
      description: 'Homemade apple pie with cinnamon and flaky crust',
      price: 6.49,
      imageUrl: 'https://images.pexels.com/photos/1055272/pexels-photo-1055272.jpeg',
    ),
    Dessert(
      id: 'ds6',
      name: 'Chocolate Brownie',
      description: 'Fudgy chocolate brownie served warm with vanilla ice cream',
      price: 5.49,
      imageUrl: 'https://images.pexels.com/photos/1998634/pexels-photo-1998634.jpeg',
    ),
  ];
}