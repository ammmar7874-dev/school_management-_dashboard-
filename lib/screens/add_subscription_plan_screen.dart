import 'package:adicto_school/data_manager.dart';
import 'package:adicto_school/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddSubscriptionPlanScreen extends StatefulWidget {
  const AddSubscriptionPlanScreen({super.key});

  @override
  State<AddSubscriptionPlanScreen> createState() =>
      _AddSubscriptionPlanScreenState();
}

class _AddSubscriptionPlanScreenState extends State<AddSubscriptionPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _durationController = TextEditingController();
  final _entriesController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _savePlan() {
    if (_formKey.currentState!.validate()) {
      final newPlan = SubscriptionPlan(
        name: _nameController.text,
        price: _priceController.text,
        duration: _durationController.text,
        entries: _entriesController.text,
        description: _descriptionController.text,
      );

      DataManager().addPlan(newPlan);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(initialIndex: 3),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      // AppBar removed
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Add Subscription Plan',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF333333),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildLabel('Plan Name'),
              _buildTextField(_nameController, "e.g 10-Class Pack"),
              const SizedBox(height: 16),
              _buildLabel('Price'),
              _buildTextField(_priceController, "e.g 200\$"),
              const SizedBox(height: 16),
              _buildLabel('Duration'),
              _buildTextField(_durationController, "30 Days"),
              const SizedBox(height: 16),
              _buildLabel('Entries Included'),
              _buildTextField(_entriesController, "e.g 10"),
              const SizedBox(height: 16),
              _buildLabel('Description'),
              _buildTextField(
                _descriptionController,
                "Short description about what this plan includes",
                maxLines: 5,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _savePlan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0085FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Save Plan',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: _inputDecoration(hint: hint),
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
    );
  }

  InputDecoration _inputDecoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.outfit(color: Colors.grey[400]),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}
