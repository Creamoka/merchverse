# 🎧 Merchverse x Hatsune Miku

Aplikasi jualan merch **Unofficial Collab Hatsune Miku**  
Project ini dibuat buat **UAS**, pakai **Flutter + Firebase**.

Santai tapi niat. Target utama: **jadi, rapi, dan bisa dipresentasiin**.

---

## 👀 Sekilas Tentang Project
Ini aplikasi e-commerce sederhana:
- Lihat produk merch
- Wishlist
- Cart
- Checkout
- History order
- Account

Backend pakai Firebase, frontend Flutter.  
Kerja tim pakai Git + branch biar ga ribet.

---

## 🛠 Tech Stack
- **Flutter**
- **Firebase**
  - Firebase Auth (Email & Password)
  - Cloud Firestore
  - Firebase Storage
- **State Management**: Provider

---

## 📂 Struktur Project
```
lib/
 ├── main.dart
 ├── app.dart
 ├── routes/
 ├── core/
 ├── models/
 ├── services/
 ├── screens/
 └── widgets/
```

Catatan:
- `screens/` → halaman aplikasi
- `widgets/` → komponen reusable
- File core & routing **jangan diutak-atik**

---

## 👥 Aturan Main Tim (WAJIB DIBACA)

### 🔀 Branch
- ❌ **DILARANG kerja di `master`**
- Setiap orang bikin branch sendiri

Contoh:
```bash
git checkout -b namakamu
```

---

### ✍️ Area Kerja
Kalian **CUMA BOLEH** ngoding di:
```
lib/screens/
lib/widgets/
```

❌ **DILARANG EDIT:**
- `main.dart`
- `app.dart`
- `routes/`
- config Firebase

Kalau ragu → tanya dulu.

---

## 📄 Cara Ngerjain Halaman
- **1 halaman = 1 file**
- Ikutin template file yang sudah ada
- Fokus UI dulu, logic belakangan

---

## 🔁 Commit & Push
- Commit kecil-kecil tapi sering
- Contoh commit message:
```
feat: add sign in page UI
fix: overflow on cart page
```

Push ke branch masing-masing, **jangan merge sendiri**.

---

## 🎯 Target Kita
- Semua halaman jadi
- App bisa jalan
- UI konsisten
- Firebase nyambung

Intinya: **yang penting jadi dan rapi**, ga usah ribet.

🔥 Semangat ngerjain, gas sampe kelar!
