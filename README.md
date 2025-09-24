# Modern Cafe Flutter App

Aplikasi cafe modern dengan tampilan inovatif dan fitur lengkap untuk tugas kuliah Flutter.

## Fitur Aplikasi

1. **Splash Screen** - Animasi loading dengan logo cafe
2. **Login Screen** - Form login dengan validasi dan logo
3. **Home Screen** - Menampilkan data user dan menu dalam tab (Food, Drinks, Desserts)
4. **Menu Display** - Grid view dengan gambar dan deskripsi setiap menu
5. **Shopping Cart** - Fitur menambah item ke keranjang
6. **Checkout** - Proses pemesanan dengan form lengkap

## Struktur Project

```
lib/
├── main.dart                 # Entry point aplikasi
├── models/
│   └── menu_item.dart       # Model data menu
├── screens/
│   ├── splash_screen.dart   # Splash screen dengan animasi
│   ├── login_screen.dart    # Login form
│   ├── home_screen.dart     # Home dengan tab menu
│   ├── cart_screen.dart     # Keranjang belanja
│   └── checkout_screen.dart # Proses checkout
└── widgets/
    ├── menu_card.dart       # Card untuk menampilkan menu
    └── cart_icon.dart       # Icon keranjang dengan badge
```

## Cara Menjalankan

1. Pastikan Flutter SDK sudah terinstall
2. Clone atau copy semua file ke project Flutter baru
3. Jalankan `flutter pub get` untuk install dependencies
4. Jalankan `flutter run` untuk menjalankan aplikasi

## Fitur UI/UX

- **Modern Design**: Menggunakan Material Design dengan color scheme coklat cafe
- **Smooth Animations**: Animasi pada splash screen dan transisi
- **Responsive Layout**: Grid layout yang responsive untuk berbagai ukuran layar
- **User-Friendly**: Interface yang intuitif dan mudah digunakan
- **Real-time Updates**: Cart badge dan total price update secara real-time

## Dependencies

- `flutter`: Framework utama
- `cupertino_icons`: Icon set untuk iOS style

## Catatan

- Gambar menu menggunakan URL dari Pexels (gratis)
- Aplikasi sudah include error handling untuk loading gambar
- Form validation sudah diimplementasi
- State management menggunakan StatefulWidget