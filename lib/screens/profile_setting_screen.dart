import 'dart:io';
import 'package:adicto_school/widgets/common_widgets.dart';
import 'package:adicto_school/widgets/screen_with_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  final ImagePicker _picker = ImagePicker();
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  List<File> _coverImages = [];
  int _currentImageIndex = 0;

  final _posterController = TextEditingController();
  final _schoolNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

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
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (image != null) {
        final file = File(image.path);
        if (await file.exists()) {
          setState(() {
            _coverImages.add(file);
            _currentImageIndex = _coverImages.length - 1;
          });

          // Wait a bit for the widget to rebuild, then animate
          await Future.delayed(const Duration(milliseconds: 100));

          // Only animate if page controller is attached
          if (mounted && _pageController.hasClients) {
            try {
              _pageController.animateToPage(
                _currentImageIndex,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } catch (e) {
              // Page controller might not be ready yet, that's okay
              debugPrint('Page controller animation error: $e');
            }
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Image file not found',
                  style: GoogleFonts.outfit(),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    } on PlatformException catch (e) {
      if (mounted) {
        String errorMessage = 'Error picking image';
        if (e.code == 'photo_access_denied' ||
            e.code == 'camera_access_denied') {
          errorMessage =
              'Permission denied. Please enable camera/gallery access in settings.';
        } else if (e.code == 'photo_picker_error') {
          errorMessage = 'Error accessing photo library';
        } else if (e.code == 'camera_error') {
          errorMessage = 'Error accessing camera';
        } else {
          errorMessage = 'Error: ${e.message ?? e.code}';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage, style: GoogleFonts.outfit()),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Unexpected error: ${e.toString()}',
              style: GoogleFonts.outfit(),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateImage(int direction) {
    if (_coverImages.isEmpty) return;

    int newIndex = _currentImageIndex + direction;
    if (newIndex < 0) {
      newIndex = _coverImages.length - 1;
    } else if (newIndex >= _coverImages.length) {
      newIndex = 0;
    }

    setState(() {
      _currentImageIndex = newIndex;
    });

    if (mounted && _pageController.hasClients) {
      try {
        _pageController.animateToPage(
          newIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } catch (e) {
        debugPrint('Page controller navigation error: $e');
      }
    }
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      // Here you would typically save to a backend or local storage
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profile settings saved successfully!',
            style: GoogleFonts.outfit(),
          ),
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
    return ScreenWithBottomNav(
      title: 'Profile Setting',
      currentIndex: 4, // More index
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 8),
              // Image Carousel
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _coverImages.isEmpty
                        ? null
                        : () => _navigateImage(-1),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 240,
                    height: 80,
                    child: _coverImages.isEmpty
                        ? GestureDetector(
                            onTap: _showImageSourceDialog,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[400]!),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                            ),
                          )
                        : PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentImageIndex = index;
                              });
                            },
                            itemCount: _coverImages.length,
                            itemBuilder: (context, index) {
                              final imageFile = _coverImages[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: FutureBuilder<bool>(
                                    future: imageFile.exists(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.data == true) {
                                        return Image.file(
                                          imageFile,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Container(
                                                  color: Colors.grey[300],
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.broken_image,
                                                      color: Colors.grey,
                                                      size: 40,
                                                    ),
                                                  ),
                                                );
                                              },
                                        );
                                      } else {
                                        return Container(
                                          color: Colors.grey[300],
                                          child: const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  IconButton(
                    onPressed: _coverImages.isEmpty
                        ? null
                        : () => _navigateImage(1),
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              if (_coverImages.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _coverImages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentImageIndex == index
                            ? const Color(0xFF0085FF)
                            : Colors.grey[300],
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: _showImageSourceDialog,
                icon: const Icon(
                  Icons.upload,
                  color: Color(0xFF0085FF),
                  size: 16,
                ),
                label: Text(
                  'Upload Cover',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFF0085FF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _posterController,
                      decoration: InputDecoration(
                        labelText: 'Add Poster',
                        hintText: 'e.g Poster School',
                        labelStyle: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF333333),
                        ),
                        hintStyle: GoogleFonts.outfit(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _schoolNameController,
                      decoration: InputDecoration(
                        labelText: 'School Name',
                        hintText: 'e.g Adicto School',
                        labelStyle: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF333333),
                        ),
                        hintStyle: GoogleFonts.outfit(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter school name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Choose Primary Color',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: _colorOptions.map((color) {
                        final isSelected = color == _selectedColor;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedColor = color;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.transparent,
                                width: isSelected ? 3 : 0,
                              ),
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                : null,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _selectedColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selected Color',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              _colorToHex(_selectedColor),
                              style: GoogleFonts.outfit(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    'Contact Information',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF333333),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomCard(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        hintText: '+971 33 55 66788',
                        labelStyle: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF333333),
                        ),
                        hintStyle: GoogleFonts.outfit(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'info@school.com',
                        labelStyle: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF333333),
                        ),
                        hintStyle: GoogleFonts.outfit(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email address';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _addressController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        hintText: '123 Street, Dubai, UAE',
                        labelStyle: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF333333),
                        ),
                        hintStyle: GoogleFonts.outfit(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter address';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              PrimaryButton(text: 'Save Changes', onPressed: _saveChanges),
            ],
          ),
        ),
      ),
    );
  }
}
