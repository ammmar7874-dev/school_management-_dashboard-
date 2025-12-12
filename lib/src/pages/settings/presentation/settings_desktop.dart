import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _posterController = TextEditingController();
  final _schoolNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  // State
  List<String> _coverImagePaths = [];
  Color _selectedColor = const Color(0xFF0085FF);
  final List<Color> _colorOptions = [
    const Color(0xFF0085FF),
    const Color(0xFF7F56D9),
    const Color(0xFF2ECC71),
    const Color(0xFFE74C3C),
    const Color(0xFFF39C12),
    const Color(0xFF9B59B6),
    const Color(0xFF1ABC9C),
    const Color(0xFF34495E),
  ];

  @override
  void dispose() {
    _posterController.dispose();
    _schoolNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source:
            ImageSource.gallery, // Simplify for desktop to gallery/file system
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _coverImagePaths.add(image.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile settings saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2, 8).toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 900;

        return Container(
          color: const Color(0xFFF5F5F5),
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cover Image Section
                  _buildCoverSection(isSmallScreen),
                  const SizedBox(height: 32),
                  // Setting Section
                  _buildSection(
                    title: 'Setting',
                    icon: Icons.settings,
                    children: [
                      _buildTextField(
                        controller: _posterController,
                        label: 'Add Poster',
                        placeholder: 'e.g School Poster',
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _schoolNameController,
                        label: 'School Name',
                        placeholder: 'e.g Adicto School',
                        validator: (v) =>
                            v?.isEmpty == true ? 'Required' : null,
                      ),
                      const SizedBox(height: 20),
                      _buildColorField(isSmallScreen),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Contact Information Section
                  _buildSection(
                    title: 'Contact Information',
                    icon: Icons.phone,
                    children: [
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email Address',
                        placeholder: 'e.g school@example.com',
                        validator: (v) =>
                            v?.contains('@') != true ? 'Invalid email' : null,
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _phoneController,
                        label: 'Phone Number',
                        placeholder: 'e.g +1 66 5544 333',
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _addressController,
                        label: 'Address',
                        placeholder: 'enter school address.....',
                        maxLines: 3,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {}, // Reset or Cancel logic
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        onPressed: _saveChanges,
                        icon: const Icon(Icons.save, color: Colors.white),
                        label: const Text(
                          'Save Changes',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCoverSection(bool isSmallScreen) {
    // Show up to 3 thumbnails + upload button
    // Stack or Row based on screen size

    Widget thumbnails = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < 3; i++) ...[
          if (i > 0) const SizedBox(width: 12),
          _buildCoverThumbnail(
            index: i,
            imagePath: i < _coverImagePaths.length ? _coverImagePaths[i] : null,
          ),
        ],
      ],
    );

    Widget uploadBtn = ElevatedButton.icon(
      onPressed: _pickImage,
      icon: const Icon(Icons.upload, color: Colors.white),
      label: const Text(
        '↑ Upload Cover',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    if (isSmallScreen) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: thumbnails,
          ),
          const SizedBox(height: 16),
          uploadBtn,
        ],
      );
    } else {
      return Row(children: [thumbnails, const SizedBox(width: 16), uploadBtn]);
    }
  }

  Widget _buildCoverThumbnail({required int index, String? imagePath}) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: imagePath != null ? Colors.grey[300] : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: imagePath != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => const Icon(Icons.broken_image),
              ),
            )
          : Icon(Icons.add, color: Colors.grey[600], size: 32),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue, size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String placeholder,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorField(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Primary Color',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        if (isSmallScreen)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildColorOptions(),
              const SizedBox(height: 12),
              _buildColorInputPreview(),
            ],
          )
        else
          Row(
            children: [
              _buildColorInputPreview(),
              const SizedBox(width: 24),
              Expanded(child: _buildColorOptions()),
            ],
          ),
      ],
    );
  }

  Widget _buildColorInputPreview() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _selectedColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
          ),
        ),
        const SizedBox(width: 12),
        // Hex Display
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
          ),
          child: Text(_colorToHex(_selectedColor).replaceAll('#', '')),
        ),
      ],
    );
  }

  Widget _buildColorOptions() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _colorOptions.map((color) {
        final isSelected = color == _selectedColor;
        return GestureDetector(
          onTap: () => setState(() => _selectedColor = color),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(color: Colors.black, width: 2)
                  : null,
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : null,
          ),
        );
      }).toList(),
    );
  }
}
