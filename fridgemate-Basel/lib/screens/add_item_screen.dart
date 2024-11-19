import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../globals.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _itemNameController = TextEditingController();
  DateTime? _purchaseDate;
  DateTime? _expiryDate;
  final _purchaseDateController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedCategory = categories[0];

  Future<void> _selectPurchaseDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _purchaseDate = picked;
        _purchaseDateController.text = DateFormat('yyyy-MM-dd').format(_purchaseDate!);
      });
    }
  }

  Future<void> _selectExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _expiryDate = picked;
        _expiryDateController.text = DateFormat('yyyy-MM-dd').format(_expiryDate!);
      });
    }
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _purchaseDateController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Add New Item', style: TextStyle(color: Colors.white, fontSize: 22)),
        backgroundColor: Colors.deepOrange,
        elevation: 4,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTitle("Add Item Details"),
                _buildCategoryDropdown(),
                _buildItemInputCard(),
                const SizedBox(height: 30),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      decoration: InputDecoration(
        labelText: 'Category',
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      items: categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value!;
        });
      },
    );
  }

  Widget _buildItemInputCard() {
    return Card(
      elevation: 6,
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _itemNameController,
              decoration: InputDecoration(
                labelText: 'Item Name',
                prefixIcon: const Icon(Icons.label_outline, color: Colors.deepOrange),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter the item name' : null,
            ),
            const SizedBox(height: 20),
            // Purchase Date Field
            TextFormField(
              controller: _purchaseDateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Purchase Date',
                prefixIcon: const Icon(Icons.calendar_today_outlined, color: Colors.deepOrange),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Select purchase date',
              ),
              onTap: () => _selectPurchaseDate(context),
            ),
            const SizedBox(height: 20),
            // Expiry Date Field
            TextFormField(
              controller: _expiryDateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Expiry Date',
                prefixIcon: const Icon(Icons.calendar_today_outlined, color: Colors.deepOrange),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Select expiry date',
              ),
              onTap: () => _selectExpiryDate(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity, // Full-width button
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 28), // Larger icon size
            label: const Text(
              'Scan with Camera',
              style: TextStyle(fontSize: 20), // Increase font size for better visibility
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              padding: const EdgeInsets.symmetric(vertical: 24), // Increase padding for a larger button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                itemList.add({
                  'name': _itemNameController.text,
                  'purchaseDate': _purchaseDate,
                  'expiryDate': _expiryDate,
                  'category': _selectedCategory,
                });
                Navigator.pop(context, true); // Pass 'true' to indicate an item was added
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              padding: const EdgeInsets.symmetric(vertical: 20), // Adjusted padding for uniformity
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text('Save Item', style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
