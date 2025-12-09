import 'package:adicto_school/widgets/common_widgets.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      // AppBar removed
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send Notification',
              style: GoogleFonts.outfit(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 20),
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
          ],
        ),
      ),
    );
  }
}
