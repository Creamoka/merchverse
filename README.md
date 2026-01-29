# Merchverse • Hatsune Miku Collaboration

Merchverse adalah aplikasi mobile bertema e-commerce merchandise yang dibuat sebagai project pembelajaran dan eksplorasi UI/UX. Aplikasi ini mengusung konsep “collaboration” dengan karakter Hatsune Miku sebagai tema utama, dengan tampilan modern, clean, dan konsisten di setiap halaman.

> ⚠️ Disclaimer: Kolaborasi ini **tidak resmi**. Project ini dibuat hanya untuk kebutuhan pembelajaran dan pengembangan skill.

---

## ✨ Tentang Aplikasi

Aplikasi ini dirancang untuk mensimulasikan pengalaman belanja merchandise, mulai dari eksplorasi produk sampai proses checkout. Fokus utama dari project ini adalah:
- Konsistensi desain UI (layout, spacing, typography)
- Navigasi aplikasi yang jelas dan smooth
- Integrasi Firebase Firestore untuk data produk
- Struktur project yang rapi dan scalable

---

## Fitur Utama

### Home Page
- Banner dan highlight event collaboration
- Featured Picks (carousel)
- Shortcut ke halaman lain lewat bottom navigation

### Product Page
- List produk dari Firestore
- Search produk berdasarkan nama
- Tampilan product card yang clean dan konsisten

### Product Detail
- Detail lengkap produk (gambar, deskripsi, harga, info lain)
- Tombol Add to Cart

### Cart & Checkout Flow
Checkout dibuat bertahap supaya terasa realistis seperti e-commerce pada umumnya:
- Cart Page
- Shipping Address
- Shipping Method
- Payment Page
- Order Summary
- Payment Success Notification
- Redirect kembali ke Home Page

### Wishlist
- Halaman wishlist untuk menyimpan produk favorit

### History
- Riwayat transaksi/pembelian user

### Account Page
- Profile section
- Edit profile
- About App
- Logout / Guest mode

---

## Firebase Integration

Project ini menggunakan Firebase Firestore sebagai database utama, khususnya untuk:
- Data produk (collection: `products`)
- Featured products (filter `isFeatured == true`)
- Penyesuaian struktur data agar mudah dikembangkan ke fitur login, cart per user, dan history per user

---

## Tech Stack

- Flutter (Dart)
- Firebase Firestore
- Firebase Auth (disiapkan untuk pengembangan login user)
- Carousel Slider
- Custom reusable widget (AppBar, BottomNav, Card)

---

## 📸 Screenshots

### Home
![Home](screenshots/home.png)

### Product
![Product](screenshots/product.png)

### Product Detail
![Detail](screenshots/detail.png)

### Cart & Checkout
![Checkout](screenshots/checkout.png)

### Payment Success
![Success](screenshots/success.png)

---

## 📦 APK Release

- **Latest Release:** `release/merchverse.apk`

---

## Team

- **Arya Maulana Yusuf** — Project Owner, App Designer, Developer
- Arrah Hilmi — Developer  
- Moch Cahyahadi F — Developer  
- Rizal — Developer  
- Syihab — Developer  

---

## Copyright / Disclaimer

Semua nama karakter, gambar, dan aset yang dipakai (contoh: **Hatsune Miku** dll) itu milik pemegang hak cipta masing-masing ya.

Aplikasi ini dibuat cuma buat **tugas / belajar / portofolio**, **bukan untuk diperjual belikan**.

Kalau ada pemegang hak cipta yang merasa keberatan, bisa dihubungi saya, nanti kontennya bakal langsung dihapus.
