import 'package:adicto_school/widgets/common_widgets.dart';
import 'package:adicto_school/widgets/screen_with_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenWithBottomNav(
      title: 'Profile Setting',
      currentIndex: 4, // More index
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ),
                _buildImagePreview(
                  'https://images.unsplash.com/photo-1542596594-649edbc13630?q=80&w=200&auto=format&fit=crop',
                ),
                const SizedBox(width: 8),
                _buildImagePreview(
                  'https://images.unsplash.com/photo-1542596594-649edbc13630?q=80&w=200&auto=format&fit=crop',
                ),
                const SizedBox(width: 8),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[400]!),
                  ),
                  child: const Center(
                    child: Icon(Icons.add, color: Colors.grey, size: 30),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {},
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
                  const CustomTextField(
                    label: 'Add Poster',
                    hint: 'e.g Poster School',
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    label: 'School Name',
                    hint: 'e.g Adicto School',
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
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0085FF), // Selected Blue
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
                            '#0087E2',
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
                  const CustomTextField(
                    label: 'Phone Number',
                    hint: '+971 33 55 66788',
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    label: 'Email Address',
                    hint: 'info@school.com',
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    label: 'Address',
                    hint: '123 Street, Dubai, UAE',
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            PrimaryButton(text: 'Save Changes', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(String url) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }
}
