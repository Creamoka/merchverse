import 'package:flutter/material.dart';

void main() {
  runApp(const MerchVerseApp());
}

class MerchVerseApp extends StatelessWidget {
  const MerchVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MerchVerse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ShippingMethodPage(),
    );
  }
}

class ShippingMethodPage extends StatefulWidget {
  const ShippingMethodPage({super.key});

  @override
  State<ShippingMethodPage> createState() => _ShippingMethodPageState();
}

class _ShippingMethodPageState extends State<ShippingMethodPage> {
  String selectedMethod = 'Standard Express';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const SizedBox(),
        title: const Text(
          'Cart - Shiping Method',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Shipping Method',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),

              // Standard Express
              ShippingMethodOption(
                title: 'Standard Express',
                isSelected: selectedMethod == 'Standard Express',
                onTap: () {
                  setState(() {
                    selectedMethod = 'Standard Express';
                  });
                },
              ),
              const SizedBox(height: 12),

              // Quick Express
              ShippingMethodOption(
                title: 'Quick Express',
                isSelected: selectedMethod == 'Quick Express',
                onTap: () {
                  setState(() {
                    selectedMethod = 'Quick Express';
                  });
                },
              ),
              const SizedBox(height: 12),

              // Instant Express
              ShippingMethodOption(
                title: 'Instant Express',
                isSelected: selectedMethod == 'Instant Express',
                onTap: () {
                  setState(() {
                    selectedMethod = 'Instant Express';
                  });
                },
              ),
              const SizedBox(height: 24),

              // Return to Address link
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back, size: 16, color: Color(0xFF4DA6E8)),
                    SizedBox(width: 6),
                    Text(
                      'Return to Address',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF4DA6E8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Continue to payment button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle continue to payment
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4DA6E8),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Continue to payment',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShippingMethodOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const ShippingMethodOption({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF4DA6E8) : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF4DA6E8)
                      : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF4DA6E8),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.black : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
