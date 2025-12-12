import 'package:adicto_school/src/shared/data/data_manager.dart';
import 'package:adicto_school/src/shared/presentation/widgets/screen_with_bottom_nav.dart';
import 'package:adicto_school/src/pages/main/presentation/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddClassScreen extends StatefulWidget {
  const AddClassScreen({super.key});

  @override
  State<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _instructorController = TextEditingController();
  final _roomController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedDate;
  String? _selectedTime;
  String? _selectedType;

  // Mock data for dropdowns
  final List<String> _dates = ['12/05/2024', '13/05/2024', '14/05/2024'];
  final List<String> _times = ['3:00 PM', '4:00 PM', '5:00 PM'];
  final List<String> _types = ['Hip hop', 'Salsa', 'Ballet', 'Yoga'];

  void _saveClass() {
    if (_formKey.currentState!.validate()) {
      final newClass = ScheduledClass(
        name: _nameController.text,
        instructor: _instructorController.text,
        date: _selectedDate ?? _dates.first,
        time: _selectedTime ?? _times.first,
        room: _roomController.text,
        type: _selectedType ?? _types.first,
        description: _descriptionController.text,
      );

      DataManager().addClass(newClass);

      // Navigate back to the Classes tab (index 1) of MainScreen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(initialIndex: 1),
        ), // Navigate to Classes tab
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWithBottomNav(
      title: 'Add Class',
      currentIndex: 1, // Classes index
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildLabel('Class Name'),
              _buildTextField(_nameController, "e.g Salsa Beginners"),
              const SizedBox(height: 16),
              _buildLabel('Instructor'),
              _buildTextField(_instructorController, "e.g Marina Gomez"),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Select Date'),
                        DropdownButtonFormField<String>(
                          decoration: _inputDecoration(hint: "e.g 12/05/2024"),
                          value: _selectedDate,
                          items: _dates
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => _selectedDate = v),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Select Time'),
                        DropdownButtonFormField<String>(
                          decoration: _inputDecoration(hint: "e.g 3:00 PM"),
                          value: _selectedTime,
                          items: _times
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => _selectedTime = v),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildLabel('Room/Studio'),
              _buildTextField(_roomController, "e.g Studio A"),
              const SizedBox(height: 16),
              _buildLabel('Select Type'),
              DropdownButtonFormField<String>(
                decoration: _inputDecoration(hint: "e.g Hip hop"),
                value: _selectedType,
                items: _types
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedType = v),
              ),
              const SizedBox(height: 16),
              _buildLabel('Description'),
              _buildTextField(
                _descriptionController,
                "Salsa beginners...................",
                maxLines: 4,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveClass,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0085FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Save Class',
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
