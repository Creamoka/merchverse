import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../routes/app_routes.dart';
import '../../models/cart_item_model.dart';

class ShippingAddressPage extends StatefulWidget {
  final List<CartItemModel> cartItems; // <-- langsung dari CartPage

  const ShippingAddressPage({super.key, required this.cartItems});

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  final _formKey = GlobalKey<FormState>();

  final _countryController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _phoneController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  bool _loading = true;
  bool _saveInformation = false;
  late String userId;

  @override
  void initState() {
    super.initState();
    final user = _auth.currentUser;
    if (user != null) {
      userId = user.uid;
      _loadUserData();
    } else {
      _loading = false;
    }
  }

  Future<void> _loadUserData() async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        final data = doc.data()!;
        _firstNameController.text = data['firstName'] ?? '';
        _lastNameController.text = data['lastName'] ?? '';
        _countryController.text = data['country'] ?? '';
        _addressController.text = data['address'] ?? '';
        _cityController.text = data['city'] ?? '';
        _postalCodeController.text = data['postalCode'] ?? '';
        _phoneController.text = data['phone'] ?? '';
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      hintText: 'Enter $label',
      labelStyle: TextStyle(color: Colors.grey[500]),
      hintStyle: TextStyle(color: Colors.grey[400]),
      floatingLabelStyle: const TextStyle(color: Color(0xFF6DBFFF)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF6DBFFF), width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  void dispose() {
    _countryController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart - Shipping',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey[300], height: 1),
        ),
      ),
      backgroundColor: Colors.white,
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Shipping Address',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Country/Region
                    TextFormField(
                      controller: _countryController,
                      decoration: _inputDecoration('Country/Region'),
                      validator: (value) =>
                          value!.isEmpty ? 'This field is required' : null,
                    ),
                    const SizedBox(height: 16),

                    // First Name & Last Name
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: _inputDecoration('First Name'),
                            validator: (value) =>
                                value!.isEmpty ? 'This field is required' : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: _inputDecoration('Last Name'),
                            validator: (value) =>
                                value!.isEmpty ? 'This field is required' : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Address
                    TextFormField(
                      controller: _addressController,
                      decoration: _inputDecoration('Address'),
                      maxLines: 2,
                      validator: (value) =>
                          value!.isEmpty ? 'This field is required' : null,
                    ),
                    const SizedBox(height: 16),

                    // City & Postal Code
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _cityController,
                            decoration: _inputDecoration('City'),
                            validator: (value) =>
                                value!.isEmpty ? 'This field is required' : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _postalCodeController,
                            decoration: _inputDecoration('Postal Code'),
                            validator: (value) =>
                                value!.isEmpty ? 'This field is required' : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Phone
                    TextFormField(
                      controller: _phoneController,
                      decoration: _inputDecoration('Phone'),
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          value!.isEmpty ? 'This field is required' : null,
                    ),
                    const SizedBox(height: 16),

                    // Save Information Checkbox
                    CheckboxListTile(
                      value: _saveInformation,
                      onChanged: (value) {
                        setState(() {
                          _saveInformation = value ?? false;
                        });
                      },
                      title: const Text('Save this information for next time'),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 16),

                    // Return to Cart
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios, size: 14, color: Colors.blue[700]),
                          const SizedBox(width: 4),
                          Text(
                            'Return to cart',
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

                    // Continue to Shipping Method
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Save info to Firestore if checked
                            if (_saveInformation) {
                              await _firestore.collection('users').doc(userId).set({
                                'firstName': _firstNameController.text,
                                'lastName': _lastNameController.text,
                                'country': _countryController.text,
                                'address': _addressController.text,
                                'city': _cityController.text,
                                'postalCode': _postalCodeController.text,
                                'phone': _phoneController.text,
                              }, SetOptions(merge: true));
                            }

                            // Prepare shipping info
                            final shippingData = {
                              'firstName': _firstNameController.text,
                              'lastName': _lastNameController.text,
                              'country': _countryController.text,
                              'address': _addressController.text,
                              'city': _cityController.text,
                              'postalCode': _postalCodeController.text,
                              'phone': _phoneController.text,
                            };

                            // Navigate to Shipping Method page
                            Navigator.pushNamed(
                              context,
                              AppRoutes.shippingMethod,
                              arguments: {
                                'cartItems': widget.cartItems,
                                'shippingAddress': shippingData,
                              },
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6DBFFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Continue to shipping',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
    );
  }
}
