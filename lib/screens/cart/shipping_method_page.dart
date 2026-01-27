import 'package:flutter/material.dart';

class ShippingMethodSelectionPage extends StatefulWidget {
  const ShippingMethodSelectionPage({Key? key}) : super(key: key);

  @override
  State<ShippingMethodSelectionPage> createState() =>
      _ShippingMethodSelectionPageState();
}

class _ShippingMethodSelectionPageState
    extends State<ShippingMethodSelectionPage> {
  String _selectedMethod = 'Standard Express';

  final List<String> _shippingMethods = [
    'Standard Express',
    'Quick Express',
    'Instant Express',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Shipping Method',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey[300],
            height: 1,
          ),
        ),
      ),
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Shipping Method',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Shipping Method Options
            ...(_shippingMethods.map((method) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildShippingMethodOption(method),
              );
            }).toList()),

            const SizedBox(height: 24),

            // Return to Address Link
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 14,
                    color: Colors.blue[700],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Return to Address',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Continue to Payment Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle navigation to payment
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Continue to payment',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingMethodOption(String method) {
    final bool isSelected = _selectedMethod == method;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = method;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue[600]! : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                method,
                style: TextStyle(
                  fontSize: 15,
                  color: isSelected ? Colors.blue[700] : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Colors.blue[600],
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}