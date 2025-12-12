import 'package:adicto_school/src/pages/notification_history/presentation/notification_history_screen.dart';
import 'package:adicto_school/src/shared/presentation/widgets/common_widgets.dart';
import 'package:adicto_school/src/shared/presentation/widgets/screen_with_bottom_nav.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({super.key});

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenWithBottomNav(
      title: 'Send Notification',
      currentIndex: 0, // Home index
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTextField(
                    label: 'Title',
                    hint: 'e.g Class Update',
                  ),
                  const SizedBox(height: 24),
                  const CustomTextField(
                    label: 'Message Body',
                    hint: 'Write your message here...',
                    maxLines: 6,
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: 'Schedule (Optional)',
                    hint: 'mm/dd/yyyy',
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                    readOnly: true,
                    onTap: () async {
                      // Date picker logic here
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            PrimaryButton(text: 'Send Now', onPressed: () {}),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationHistoryScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.history, color: Color(0xFF0085FF)),
              label: Text(
                'History',
                style: GoogleFonts.outfit(
                  color: const Color(0xFF0085FF),
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Color(0xFF0085FF)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
