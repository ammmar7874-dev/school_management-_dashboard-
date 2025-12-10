import 'package:adicto_school/data_manager.dart';
import 'package:adicto_school/screens/main_screen.dart';
import 'package:adicto_school/widgets/screen_with_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddSubscriptionPlanScreen extends StatefulWidget {
  final SubscriptionPlan? planToEdit;
  final int? planIndex;
  const AddSubscriptionPlanScreen({super.key, this.planToEdit, this.planIndex});

  @override
  State<AddSubscriptionPlanScreen> createState() =>
      _AddSubscriptionPlanScreenState();
}

class _AddSubscriptionPlanScreenState extends State<AddSubscriptionPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _durationController;
  late final TextEditingController _entriesController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.planToEdit?.name ?? '',
    );
    _priceController = TextEditingController(
      text: widget.planToEdit?.price ?? '',
    );
    _durationController = TextEditingController(
      text: widget.planToEdit?.duration ?? '',
    );
    _entriesController = TextEditingController(
      text: widget.planToEdit?.entries ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.planToEdit?.description ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _durationController.dispose();
    _entriesController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _savePlan() {
    if (_formKey.currentState!.validate()) {
      final plan = SubscriptionPlan(
        name: _nameController.text,
        price: _priceController.text,
        duration: _durationController.text,
        entries: _entriesController.text,
        description: _descriptionController.text,
      );

      if (widget.planToEdit != null && widget.planIndex != null) {
        DataManager().updatePlan(widget.planIndex!, plan);
      } else {
        DataManager().addPlan(plan);
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(initialIndex: 2),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWithBottomNav(
      title: widget.planToEdit != null
          ? 'Edit Subscription Plan'
          : 'Add Subscription Plan',
      currentIndex: 2, // My Plan index
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
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
                    widget.planToEdit != null ? 'Update Plan' : 'Save Plan',
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
