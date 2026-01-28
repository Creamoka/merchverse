import 'package:flutter/material.dart';
import '../../widgets/merchverse_appbar.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _countryController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _phoneController = TextEditingController();

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
      appBar: const MerchverseAppBar(showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage('assets/images/image 22.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF6DBFFF),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),

            _field(controller: _countryController, hint: 'Country/Region'),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: _field(controller: _firstNameController, hint: 'First Name'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _field(controller: _lastNameController, hint: 'Last Name'),
                ),
              ],
            ),
            const SizedBox(height: 14),

            _field(controller: _addressController, hint: 'Address'),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(child: _field(controller: _cityController, hint: 'City')),
                const SizedBox(width: 12),
                Expanded(
                  child: _field(controller: _postalCodeController, hint: 'Postal Code'),
                ),
              ],
            ),
            const SizedBox(height: 14),

            _field(controller: _phoneController, hint: 'Phone'),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Discard'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile saved successfully')),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontFamily: 'Montserrat', fontSize: 13),
      decoration: InputDecoration(hintText: hint),
    );
  }
}
