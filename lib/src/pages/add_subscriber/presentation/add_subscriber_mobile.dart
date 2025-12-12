import 'package:adicto_school/src/shared/presentation/widgets/screen_with_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddSubscriberScreen extends StatefulWidget {
  const AddSubscriberScreen({super.key});

  @override
  State<AddSubscriberScreen> createState() => _AddSubscriberScreenState();
}

class _AddSubscriberScreenState extends State<AddSubscriberScreen> {
  String? selectedPlan;
  String paymentMethod = 'Cash';

  @override
  Widget build(BuildContext context) {
    return ScreenWithBottomNav(
      title: 'Add New Subscriber',
      currentIndex: 3, // Subscriber index
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            _buildLabel('Name'),
            _buildTextField('e.g Ayesha Khan'),
            const SizedBox(height: 20),
            _buildLabel('Phone Number'),
            _buildTextField(
              'e.g Marina Gomez',
            ), // Matches screenshot placeholder
            const SizedBox(height: 20),
            _buildLabel('Email Address'),
            _buildTextField('e.g ayesha@example.com'),
            const SizedBox(height: 20),
            _buildLabel('Choose Plan'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedPlan,
                  hint: Text(
                    'Select a subscription plan',
                    style: GoogleFonts.outfit(color: Colors.grey),
                  ),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: ['10-Class Pack', 'Monthly Unlimited', '5-Class Pack']
                      .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: GoogleFonts.outfit()),
                        );
                      })
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedPlan = newValue;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildLabel('Select Payment Method'),
            _buildRadioOption('Cash'),
            const SizedBox(height: 12),
            _buildRadioOption('Card'),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0085FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Save Subscriber',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
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

  Widget _buildTextField(String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.outfit(color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption(String value) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: RadioListTile<String>(
        title: Text(value, style: GoogleFonts.outfit()),
        value: value,
        groupValue: paymentMethod,
        onChanged: (newValue) {
          setState(() {
            paymentMethod = newValue!;
          });
        },
        activeColor: const Color(0xFF0085FF),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
